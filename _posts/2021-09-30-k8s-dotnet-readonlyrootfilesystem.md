---
title: "Quick Note: Containerized dotnet and readOnlyRootFilesystem"
last_modified_at: 2021-09-30T20:30:00+02:00
categories:
  - Blog
  - Tech
tags:
  - Dotnet
  - Kubernetes
  - SecurityContext
---

One security measure in Kubernetes is to specify a `securityContext` and set `readOnlyRootFilesystem` to `true`.
This will stop the applications in the container to write to the container file system and only be able to write to mounted volumes.

This, however, can stop your dotnet application from running at all and yield the error message:

```log
Failed to initialize CoreCLR, HRESULT: 0x80004005
```

This can be resolved by specifying the following in your Dockerfile

```dockerfile
ENV COMPlus_EnableDiagnostics=0
```

Shoutout to natemcmaster in this [GitHub issue](https://github.com/aspnet/aspnet-docker/issues/331#issuecomment-461857629)
