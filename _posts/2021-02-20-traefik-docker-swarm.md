---
title: "Traefik ft. Docker Swarm"
last_modified_at: 2021-01-24T21:12:02+01:00
excerpt: "Configuring Traefik v2 with auto-discovery in Docker Swarm"
classes: wide
categories:
  - Blog
tags:
  - Traefik
  - Docker
  - Swarm
---

## Traefik

Reverse proxy in Docker Swarm has multiple viable solutions, but one method that requires little maintenance of the loadbalancer is to use auto-discovery.
[Traefik](https://doc.traefik.io/traefik/) has support for auto-discovery in Docker and Docker Swarm.

Traefik v2 requires:

- A Traefik service (container) in the cluster with access to the Docker socket
- Deployment labels on the containers to which Traefik should route trafic

Simple isn't it?

## Configuring Traefik

Configuring Traefik isn't really that difficult, but it isn't that intuitive either.
However, in most cases, the code below will suffice, so feel free to copy and use these configs.

### Minimal Configuration

This configuration is the minimum required to get automatic routing on port 80.
My interpretation of the configuration is added as comments in the configuration in the next section.

```yml
version: "3.8"

services:
  traefik:
    image: traefik:v2.4.3
    networks:
      - proxy
    ports:
      - 80:80
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
    command:
      - "--providers.docker=true"
      - "--providers.docker.swarmMode=true"
      - "--providers.docker.exposedbydefault=false"
      - "--providers.docker.network=proxy"
      - "--entrypoints.web.address=:80"
    deploy:
      placement:
        constraints:
          - node.role == manager
```

### Configuration with protected Traefik Dashboard

This configuration is a bit more detailed, but it has the dashboard and API enabled, secured by a basicauth middleware.

```yml
version: "3.8"

services:
  traefik:
    image: traefik:v2.4.3
    networks:
      - proxy
    ports:
      - 80:80 # The host port 80 routes to port 80 (for the entrypoint 'web' defined below)
      - 8080:8081 # 8080 routes to 8081 (for the entrypoint 'traefik-internal' defined below)
    volumes:
      # map the host docker socket to the container path, enabling auto-discovery
      - /var/run/docker.sock:/var/run/docker.sock:ro
    command:
      - "--log.level=INFO" # Set the loglevel (DEBUG, INFO, WARN, ERROR, PANIC, FATAL)
      - "--ping" # Enable the Traefik /ping endpoint, can be used for healthcheck
      - "--api=true" # Enable the Traefik API
      # "--api.insecure=true" # Traefik API will listen to port 8080
      - "--api.dashboard=true" # Enable Traefik Dashboard
      - "--providers.docker=true" # Configura Traefik to use the Docker provider
      - "--providers.docker.swarmMode=true" # Docker Swarm, reading deploy labels
      - "--providers.docker.exposedbydefault=false" # Requires the label "traefik.enable=true"
      - "--providers.docker.network=proxy" # Use the Docker network 'proxy'
      - "--entrypoints.web.address=:80" # Define the entrypoint 'web' at port 80
      - "--entrypoints.traefik-internal.address=:8081"
    deploy:
      placement:
        constraints:
          - node.role == manager # Only deploy this service to nodes that are managers

      # Note that the following are service.deploy.labels and not service.labels
      labels:
        - "traefik.enable=true" # Enable routing to this service

        # Define the router 'api' and use the entrypoints.traefik.address specified above (:8081)
        - "traefik.http.routers.api.entrypoints=traefik-internal"

        # The router should only relay paths starting with either /api or /dashboard
        - "traefik.http.routers.api.rule=(PathPrefix(`/api`) || PathPrefix(`/dashboard`))"
        # TODO
        - "traefik.http.routers.api.service=api@internal" 
        # This router uses the middleware 'auth'
        - "traefik.http.routers.api.middlewares=auth"

        # Define the middleware 'auth' as a basicauth middleware
        # Replace 'xyz' with a hashed password (e.g. $$apr1$$wtmvidg3$$lDYGOEBdGOiy/4BbgKSuV/)
        # Note that '$' must be escaped with another '$'
        # linux shorthand: echo $(htpasswd -nb myusername mypassword) | sed -e s/\\$/\\$\\$/g
        - "traefik.http.middlewares.auth.basicauth.users=myusername:xyz"
        
        # Traefik, in it's infinite wisdom, requires a service to be defined
        # "Dummy service for Swarm port detection. The port can be any valid integer value"
        # ref: https://doc.traefik.io/traefik/operations/dashboard/
        # TL;DR: Service name and port number doesn't matter, but something must be here
        - "traefik.http.services.dummy-svc.loadbalancer.server.port=1234"
```


## Web services

When the Traefik service is deployed, requests should be routed to other services in the same network, as long as they are labelled correctly.

```yml
services:
  my-web-service:
    networks:
      # Connect the service to the same network as the Traefik service
      - proxy
    deploy:
      labels:
        # Enable Traefik discovery
        - "traefik.enable=true"
        # Define the 'mywebservice' router with the 'web' entrypoint
        - "traefik.http.routers.mywebservice.entrypoints=web"
        # Only route requests with the path prefix
        - "traefik.http.routers.mywebservice.rule=PathPrefix(`/my/web/service/path`)"
        # Define service 'mywebservice' and route requests to port 8080
        - "traefik.http.services.mywebservice.loadbalancer.server.port=8080"
```
