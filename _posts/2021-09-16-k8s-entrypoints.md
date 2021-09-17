---
title: "Kubernetes Experience"
last_modified_at: 2021-09-16T17:12:02+02:00
excerpt: "..."
categories:
  - Blog
  - Tech
tags:
  - Beginner
  - DevOps
  - Kubernetes
  - Ingress
---

I recently was tasked with the challenge of providing two different domains for the same Kubernetes cluster.
Easy enough in itself, but the catch was that one should be private and only available through the internal network at the office.
The private applications were support applications for the public APIs and were necessary on the developer machines when testing the public APIs locally.
Turns out there wasn't a guide for this, or rather there were, but misleading ones, and I want to provide a solution that is at least valid September, 2021.

## Problem

TODO describe problem

{: .text-center}
![Figure](/assets/posts/devops/silos.svg){: .align-center}
*Wanted solution*


## Solution

First attempt. I want another Nginx Ingress Controller, so I install another with a different name. Should be simple, right?

```sh
helm install private-ingress ingress-nginx/ingress-nginx \
    --set controller.service.loadbalancerIP='privateIP'
```

While using Nginx through Helm, only specifying another name for the *Helm release* is not enough.
This will instantiate another Nginx Ingress Controller, but it won't have another controller name from the Kubernetes perspective.


```sh
helm install private-ingress ingress-nginx/ingress-nginx \
    --set controller.ingressClassResource.name='private-controller'
    --set controller.ingressClassResource.controllerValue='k8s.io/ingress-nginx-private'
```

As seen in the [Nginx Ingress Controller Chart Values](https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/values.yaml), blah



## Resources

- *Nginx Ingress Controller Chart Values* - [GitHub/Kubernetes](https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/values.yaml)
