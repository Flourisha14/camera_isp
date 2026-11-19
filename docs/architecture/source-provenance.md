# Source Provenance

## Project

Rove Tech Camera ISP Hiring Assignment

Repository:
https://github.com/Flourisha14/camera_isp

## Original Project Components

The following components will be developed specifically for this assignment:

- meta-isp-assignment Yocto layer
- isp-image BitBake recipe
- Camera ISP application
- Meson build configuration
- systemd integration
- Automated tests
- CI workflows

## Upstream Components

The implementation is expected to use:

- Poky / OpenEmbedded
- meta-openembedded
- libcamera
- GStreamer
- QEMU
- Meson
- Ninja

Upstream repositories, revisions, licenses, and relevant patches
will be documented when dependencies are introduced.

## Reproducibility Policy

1. Pin upstream layer revisions.
2. Avoid floating branches for reproducible releases.
3. Document externally sourced code and modifications.
4. Keep generated artifacts outside Git.
5. Record build commands and tool versions.
6. Preserve independent QA evidence.

## Current Status

Yocto image and application implementation are out of scope.