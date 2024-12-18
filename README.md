# FreeRadius Docker Container

[![Latest Build Status](https://github.com/goofball222/freeradius/actions/workflows/build-latest.yml/badge.svg)](https://github.com/goofball222/freeradius/actions/workflows/build-latest.yml) [![Docker Pulls](https://img.shields.io/docker/pulls/goofball222/freeradius.svg)](https://hub.docker.com/r/goofball222/freeradius/) [![Docker Stars](https://img.shields.io/docker/stars/goofball222/freeradius.svg)](https://hub.docker.com/r/goofball222/freeradius/) [![License](https://img.shields.io/github/license/goofball222/freeradius.svg)](https://github.com/goofball222/freeradius)

## Docker tags:
| Tag | freeradius Version | Description | Release Date |
| --- | :---: | --- | :---: |
| [latest](https://github.com/goofball222/freeradius/blob/main/stable/Dockerfile) | 3.0.26 | Latest stable release | 2022-12-20 |

---

* [Recent changes, see: GitHub CHANGELOG.md](https://github.com/goofball222/freeradius/blob/main/CHANGELOG.md)
* [Report any bugs, issues or feature requests on GitHub](https://github.com/goofball222/freeradius/issues)

---

## Description

FreeRadius container built on Alpine Linux.

See: [https://wiki.freeradius.org/guide/Basic-configuration-HOWTO](https://wiki.freeradius.org/guide/Basic-configuration-HOWTO) and the rest of the FreeRadius Wiki for setup help.

---

## Usage

This container exposes the following two ports:
* `1812/udp` freeradius authorization service port
* `1813/udp` freeradius accounting service port

---

**Basic docker-compose.yml to launch a FreeRadius instance and make it accessible*

```bash

version: '3'

services:
  freeradius:
    image: goofball222/freeradius
    container_name: freeradius
    network_mode: bridge
    restart: unless-stopped
    ports:
      - 1812:1812/udp
      - 1813:1813/udp
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - ./clients.conf:/etc/raddb/clients.conf
      - ./radiusd.conf:/etc/raddb/radiusd.conf
      - ./authorize:/etc/raddb/mods-config/files/authorize
      - ./certs:/etc/freeradius/certs
    environment:
      - TZ=UTC

```

---


**Environment variables:**

| Variable | Default | Description |
| :--- | :---: | --- |
| `DEBUG` | ***false*** | Set to *true* for extra entrypoint script verbosity for debugging |
| `PGID` | ***999*** | Specifies the GID for the container internal radius group (used for file ownership) |
| `PUID` | ***999*** | Specifies the UID for the container internal radius user (used for process and file ownership) |
| `RADIUSD_OPTS` | ***unset*** |  Any additional custom run options for the container radiusd process |

[//]: # (Licensed under the Apache 2.0 license)
[//]: # (Copyright 2018 The Goofball - goofball222@gmail.com)
