# Mini Donkey
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![Flutter](https://img.shields.io/badge/built%20with-Flutter-brightgreen)](https://flutter.dev/docs)
[![Issues](https://img.shields.io/github/issues/tianhaoz95/photochat)](https://github.com/tianhaoz95/photochat/issues)
[![Pull requests](https://img.shields.io/github/issues-pr/tianhaoz95/photochat)](https://github.com/tianhaoz95/photochat/pulls)
[![GitHub license](https://img.shields.io/github/license/tianhaoz95/photochat)](https://github.com/tianhaoz95/photochat/blob/master/LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/tianhaoz95/photochat/graphs/commit-activity)

**Mini Donkey** carries private messages **securely** and **secretly** with encryption ([AES](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)) and [steganography](https://en.wikipedia.org/wiki/Steganography) (technique of concealing messages in images).

## Repository Status

| Task ID | Description | Status @ [master](https://github.com/tianhaoz95/photochat) | Link |
|:----:|:-----------:|:------:|:----:|
| Heimdall | Static analysis, lint and unit tests | ![heimdall](https://github.com/tianhaoz95/photochat/workflows/heimdall/badge.svg?branch=master) | [check heimdall status](https://github.com/tianhaoz95/photochat/actions?query=workflow%3Aheimdall+branch%3Amaster) |
| Thor | End to end tests | ![thor](https://github.com/tianhaoz95/photochat/workflows/thor/badge.svg?branch=master) |  [check thor status](https://github.com/tianhaoz95/photochat/actions?query=workflow%3Athor+branch%3Amaster) |
| Loki | App release | ![loki](https://github.com/tianhaoz95/photochat/workflows/loki/badge.svg?branch=master) |  [check loki status](https://github.com/tianhaoz95/photochat/actions?query=workflow%3Aloki+branch%3Amaster) |
|Gitpod | Prebuilt workspace | ![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod) | [open workspace](https://gitpod.io/#https://github.com/tianhaoz95/photochat) |

## Getting started

| Platform | Download | Alternative Source |
|:--------:|:--------:|:------------------:|
| Android | [![get it on play store](assets/post/google_play_store_logo.png)](https://play.google.com/store/apps/details?id=com.jacksonz.photochatapp) | Coming soon ... |
| iOS | Coming soon... (too poor to buy the $99/year Apple developer account) | Coming soon ... |
| Web | Not planned (pending on Flutter support) | Not planned (pending on Flutter support) |
| MacOS | Not planned (pending on Flutter support) | Not planned (pending on Flutter support) |
| Windows | Not planned (pending on Flutter support) | Not planned (pending on Flutter support) |
| Linux | Not planned (pending on Flutter support) | Not planned (pending on Flutter support) |

## Design

### Encoding Flow: Message -> Encryption -> Encoding (Steganography) -> Image

![encoding flow](./assets/post/encoding_flow.png)

### Decoding Flow: Image -> Message Extraction -> Decryption -> Message

![decoding flow](./assets/post/decoding_flow.png)

## Demo

### Encoding Flow: Message -> Encryption -> Encoding (Steganography) -> Image

![encoding app demo](./assets/post/encoding_flow_app_demo.png)

### Decoding Flow: Image -> Message Extraction -> Decryption -> Message

![decoding app demo](./assets/post/decoding_flow_app_demo.png)

## Contribute

To ensure the transparency of the implementation (so that no privacy message get stolen secretly), Mini Donkey is completely open source. All kinds of contribution including but not limited to pull requests, feature requests, bug reports, sponsorship, etc, are welcome.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="http://tianhaoz.com"><img src="https://avatars3.githubusercontent.com/u/16887772?v=4" width="100px;" alt=""/><br /><sub><b>Tianhao Zhou</b></sub></a><br /><a href="https://github.com/tianhaoz95/photochat/commits?author=tianhaoz95" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!