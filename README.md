# Mini Donkey

Mini Donkey carries private messages securely and secretly by encrypting and encoding messages into images.

> Smart: my chats are encrypted. Next level: my chats are encrypted but I pretend they are not.

## Repository Status

| Task | Description | Status |
|:-----:|:-----------:|:------:|
| Heimdall | Static analysis, lint and unit tests | ![heimdall](https://github.com/tianhaoz95/photochat/workflows/heimdall/badge.svg?branch=master) |
| Thor | End to end tests | ![thor](https://github.com/tianhaoz95/photochat/workflows/thor/badge.svg?branch=master) |
| Loki | App release | ![loki](https://github.com/tianhaoz95/photochat/workflows/loki/badge.svg?branch=master) |
|Gitpod | Prebuilt workspace | [![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/tianhaoz95/photochat) |

## Getting started

| Platform | Download | Alternative Source |
|:--------:|:--------:|:------------------:|
| Android | ![get it on play store](assets/post/google_play_store_logo.png) | Coming soon ... |
| iOS | Coming soon... (too poor to buy the $99/year Apple developer account) | Coming soon ... |
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

To ensure the transparency of the implementation (so that no privacy message get stolen secretly), Mini Donkey is completely open source.

All kinds of contribution including but not limited to pull requests, feature requests, bug reports, sponsorship, etc, are welcome.
