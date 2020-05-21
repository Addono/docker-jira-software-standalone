# Docker Jira Software Standalone
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![License](https://img.shields.io/github/license/Addono/docker-jira-software-standalone?style=flat-square)](https://github.com/Addono/docker-jira-software-standalone/blob/master/LICENSE)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://img.shields.io/badge/project%20status-Active-greengrass?style=flat-square)](https://www.repostatus.org/#active)<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-0-orange.svg?style=flat-square)](#contributors-)

<!-- ALL-CONTRIBUTORS-BADGE:END -->


## 📝 Table of Contents

- [About](#about)
- [Running the Tests](#tests)
- [Contributors](#contributors)

## 🧐 About <a name = "about"></a>

Dockerized version of Jira Software to easily spin up development versions without having to deal with the hassle of managing licences.

This image uses  `atlas-cli` to create an empty Jira Software instance by launching a development environment for an empty plugin. Starting this development environment can be very slow (expect it to take more than 5 minutes), so this is best used for asyncronous tasks, such as running in your CI pipeline.

## 🎈 Usage <a name="usage"></a>

Using it is easy, to run it in the foreground:
```bash
docker run -it -p 2990:2990 --name jira addono/jira-software-standalone
```

Or in detached mode to run it in the background:
```bash
docker run -d -it -p 2990:2990 --name jira addono/jira-software-standalone
```

_Note: Make sure that the `-i` flag is enabled, as without it the server will exit the moment it completed booting._

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
## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!