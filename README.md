# Docker Jira Software Standalone


[![License](https://img.shields.io/github/license/Addono/docker-jira-software-standalone?style=flat-square)](https://github.com/Addono/docker-jira-software-standalone/blob/master/LICENSE)
[![Project Status: Unsupported – The project has reached a stable, usable state but the author(s) have ceased all work on it. A new maintainer may be desired.](https://www.repostatus.org/badges/latest/unsupported.svg)](https://www.repostatus.org/#unsupported)
![GitHub Workflow Status - Docker](https://img.shields.io/github/actions/workflow/status/Addono/docker-jira-software-standalone/dockerpublish.yml?style=flat-square)
[
![Docker Image Pulls (all-time)](https://img.shields.io/docker/pulls/addono/jira-software-standalone?style=flat-square)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/addono/jira-software-standalone?sort=semver&style=flat-square)
](https://hub.docker.com/r/addono/jira-software-standalone)<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->


## 📝 Table of Contents

- [About](#about)
- [Usage](#usage)
- [Contributors](#contributors)

## 🧐 About <a name = "about"></a>

Dockerized version of Jira Software to easily spin up development versions without having to deal with the hassle of managing licences.

This image uses  `atlas-cli` to create an empty Jira Software instance by launching a development environment for an empty plugin. Starting this development environment can be very slow (expect it to take more than 5 minutes), so this is best used for asyncronous tasks, such as running in your CI pipeline.

## 🎈 Usage <a name="usage"></a>

This image is published to [Docker Hub](https://hub.docker.com/r/addono/jira-software-standalone). Using them is easy, to run it in the foreground:
```bash
docker run -it -p 2990:2990 --name jira addono/jira-software-standalone
```

Or in detached mode as to run it in the background:
```bash
docker run -d -it -p 2990:2990 --name jira addono/jira-software-standalone
```

_Note: Make sure that the `-i` flag is enabled, as without it the server will exit the moment it completed booting._

### Targeting a different Jira version

The Dockerfile is parameterised; every value that changes between Jira majors
is exposed as a `--build-arg`. `scripts/render-pom.sh` substitutes the matching
`@TOKEN@` placeholders in `plugin/pom.xml.template` into a real `plugin/pom.xml`
during the build, so the same source tree builds Jira 8 through Jira 11.

```bash
docker build \
  --build-arg JAVA_IMAGE=eclipse-temurin:21-jdk-jammy \
  --build-arg AMPS_VERSION=9.11.2 \
  --build-arg JIRA_VERSION=11.3.4 \
  --build-arg SPRING_SCANNER_VERSION=6.0.0 \
  --build-arg COMPILE_FLOOR=17 \
  -t jira-software-standalone:11.3.4 .
```

Defaults target the latest Jira 8 LTS (8.20.30 / Java 8 / AMPS 8.2.3) so a
bare `docker build .` continues to produce the historical Jira 8 image.

#### Known-good build-arg combinations

Each row has been validated against a fresh `atlas-run` boot. Pass these
as `--build-arg` flags when building locally, or as workflow inputs in
`.github/workflows/ghcr-publish.yml`.

| Jira version | `JAVA_IMAGE`                  | `AMPS_VERSION` | `SPRING_SCANNER_VERSION` | `TESTRUNNER_VERSION` | `COMPILE_FLOOR` |
|--------------|-------------------------------|----------------|--------------------------|----------------------|-----------------|
| 8.20.30      | `eclipse-temurin:8-jdk-jammy`  | `8.2.3`        | `2.1.17`                 | `2.0.16`             | `1.8`           |
| 9.12.34      | `eclipse-temurin:11-jdk-jammy` | `9.1.2`        | `2.2.6`                  | `2.0.16`             | `11`            |
| 10.3.19      | `eclipse-temurin:17-jdk-jammy` | `9.1.2`        | `2.2.6`                  | `2.0.16`             | `17`            |
| 11.3.4       | `eclipse-temurin:21-jdk-jammy` | `9.11.2`       | `6.0.0`                  | `2.0.16`             | `17`            |

Notes on the `AMPS_VERSION` line:

- `AMPS_VERSION` feeds two artefacts that share a release train but
  can drift: the SDK tarball (`atlassian-plugin-sdk`, consumed by
  `scripts/install-sdk.sh`) and the build extension
  (`com.atlassian.maven.plugins:jira-maven-plugin`, consumed by
  `plugin/pom.xml.template`). Both must resolve at the chosen
  version. Verify against
  [the SDK metadata](https://packages.atlassian.com/maven-external/com/atlassian/amps/atlassian-plugin-sdk/maven-metadata.xml)
  and
  [the plugin metadata](https://packages.atlassian.com/maven-external/com/atlassian/maven/plugins/jira-maven-plugin/maven-metadata.xml).
- For Jira 8 the SDK ships through `8.2.10` but the
  `jira-maven-plugin` 8.2.x line tops out at `8.2.3`, so `8.2.3` is
  the highest value that resolves on both paths.
- For Jira 9 the older 8.2.x SDK ships an `atlas-run` that calls
  `jira-maven-plugin:8.2.3` internally, which predates Jira 9 and
  fails to launch a 9.x instance. The 9.1.x line is the lowest AMPS
  that handles both Jira 9 and 10 cleanly (Spring 5 / `javax.*`
  baseline carries through; Maven 3.9 in SDK 9.1.x runs on Java 11+).
- `SPRING_SCANNER_VERSION` is Jakarta-locked to Jira's Spring major:
  2.1.x for Jira 8, 2.2.x for Jira 9-10, 6.x for Jira 11. Crossing
  the streams (2.x against `jakarta.*`, 6.x against `javax.*`)
  silently no-ops at scan time.

The Dockerfile is multi-stage: the default `unwarmed` target cold-boots on
every container start (~10–20 min), and `--target warmed` bakes the result of
one full `atlas-run` boot into the image so subsequent containers reach
`/serverInfo` in ~1–2 min, at the cost of ~25 min of build time.

`.github/workflows/ghcr-publish.yml` is a `workflow_dispatch` job that exposes
every build-arg as an input and publishes both the unwarmed and warmed
variants on every run; the optional `tag_latest` flag also pushes
`:<major>-latest` and `:<major>-warm-latest` floating tags.

## Travis CI

This is one way on how to use this image in a Travis CI pipeline. Add the following lines to your `.travis.yaml` file and access it at the location specified in the environment variables.

```yaml
# Let the CI runner provision Docker for us
services:
  - docker

# Spin up the Jira instance before we run our jobs
before_install:
# Launch a Jira instance in detached mode
  - docker run -dit -p 2990:2990 --name jira addono/jira-software-standalone
# Wait until Jira has booted
  - until $(curl -u $CI_JIRA_ADMIN:$CI_JIRA_ADMIN_PASSWORD --output /dev/null --silent --head --fail $CI_JIRA_URL/rest/api/2/permissions); do sleep 5; done

# Set the default hostname and admin user credentials as environment variables
env:
  global:
    - CI_JIRA_URL=http://localhost:2990/jira
    - CI_JIRA_ADMIN=admin
    - CI_JIRA_ADMIN_PASSWORD=admin
```



## ✨ Contributors <a name = "contributors"></a>

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://aknapen.nl"><img src="https://avatars1.githubusercontent.com/u/15435678?v=4" width="100px;" alt=""/><br /><sub><b>Adriaan Knapen</b></sub></a><br /><a href="https://github.com/Addono/docker-jira-software-standalone/commits?author=addono" title="Code">💻</a> <a href="https://github.com/Addono/docker-jira-software-standalone/commits?author=addono" title="Tests">⚠️</a> <a href="https://github.com/Addono/docker-jira-software-standalone/commits?author=addono" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
