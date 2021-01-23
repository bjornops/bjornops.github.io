---
title: "Docker Cheat Sheet"
last_modified_at: 2021-01-22T20:12:02+01:00
categories:
  - Blog
  - Tech
tags:
  - Docker
---

# Docker resources

This article serves as a reference for a pretty standard Docker workflow, trying to adhere to the best practices.

## Docker CLI

Working with Docker in the command line. [Docker CLI Reference](https://docs.docker.com/engine/reference/commandline/cli/)

### Commonly used commands

```shell
docker -v

```

## Dockerfile

Building an image containing your application.

**Example Dockerfile**

```Dockerfile
# TODO: Create dotnet best practice dockerfile, including ADD and other Dockerfile actions

FROM dotnet-alpine

ADD *
```

## Docker Compose

Deploying your image. [Docker Compose 3 Reference](https://docs.docker.com/compose/compose-file/compose-file-v3/)

**Example Compose File**

```yaml
# TODO: Create a feature complete compose file
version: "3.8"

```
