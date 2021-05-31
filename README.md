# Docker Jira Software Standalone


[![License](https://img.shields.io/github/license/Addono/docker-jira-software-standalone?style=flat-square)](https://github.com/Addono/docker-jira-software-standalone/blob/master/LICENSE)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://img.shields.io/badge/project%20status-Active-greengrass?style=flat-square)](https://www.repostatus.org/#active)
![GitHub Workflow Status - Docker](https://img.shields.io/github/workflow/status/Addono/docker-jira-software-standalone/Docker?style=flat-square)
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
