---
title: "Introduction to Kubernetes - A non-technical approach"
last_modified_at: 2022-01-23T20:12:02+02:00
excerpt: ""
categories:
  - Blog
  - Tech
tags:
  - Beginner
  - Kubernetes
---

This is an article for those to needs to know how Kubernetes works, from a practical point of view.
You may be a product owner that wants know the relations between the different components or a student that wants to get an overview before delving into the YAML files.



## Containers

Containers is the fundament of Kubernetes, which just is a container orchestrating tool.
There are many articles on containers, so I won't go into much detail here.
**todo: find container articles**
The main concept is that you create an environment in which your application runs and the environment contains all the dependencies that the app needs to run.
Without any intervene from Operations, you can use, upgrade and run multiple versions of dotnet, java, python, etc. without them interfering with each other.

## Case

Instead of explaining abstractly how the most relevant components of Kubernetes works, we're going to use a concrete example.

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/case.png){: .align-center}
**



## Kubernetes


### Pods

Pods are the instances of your application, and just an encapsulation of the container described above.

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/kubernetes-pod.png){: .align-center}
*A pod. In this case with just one container*


### Node

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/kubernetes-node.png){: .align-center}
*A Kubernetes node*

### Service

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/kubernetes-service.png){: .align-center}
*A service with two pods*

### Ingress

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/kubernetes-ingress.png){: .align-center}
*An ingress that points to a single service*

### Namespace

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/kubernetes-namespace.png){: .align-center}
*A namespace covering two services, X and Y.*

### Case solution

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/kubernetes-applied-architecture.png){: .align-center}
*A solution for the aforementioned case*

## Evaluating Kubernetes

Kubernetes is a great tool for container orchestration.
However, that does not mean it is a great solution for everything.

Kubernetes is best suited for stateless and horizontally scalable applications, especially with fluctuating traffic or load.
One of the best, and thankfully most used, case is web applications, e.g. APIs, websites, etc.

Other applications, such as machine learning tasks that have special hardware requirements, offline programs and games are not well suited for running in a Kubernetes cluster.

## Resources

- *What Is DevOps?* - [New Relic](https://newrelic.com/devops/what-is-devops)
- *DevOps is a culture, not a role!* [Medium](https://neonrocket.medium.com/devops-is-a-culture-not-a-role-be1bed149b0)
- [*The DevOps Handbook*](https://itrevolution.com/the-devops-handbook/) by Gene Kim, Jez Humble, Patrick Debois, and John Willis
- [*The Phoenix Project*](https://itrevolution.com/the-phoenix-project/) by Gene Kim, Kevin Behr and George Spafford
- *DevOps Roadmap* - [roadmap.sh](https://roadmap.sh/devops)
- *Site Reliability Engineering* - [sre.google](https://sre.google/workbook/how-sre-relates/)
- *The DevOps Checklist* - [devopschecklist.com](https://devopschecklist.com)

<!-- 
- Flow (task workflow)
  - Deployment pipeline
  - Automated testing
  - Low-risk releases
    - Blue-green, A/B
    - Monolith/services/microservices
    - Feature flags
- Feedback loops
  - telemetry
    - business
    - application
    - infrastructure
    - clients
    - deployment

## Outline
**Software development Life Cycle**
- Analysis
  - Dev
    - Features
  - Ops
    - Delivery
- Problem description
  - Conflicting goals
    - Waterfall product
  - Not knowing what's happening
  - Not knowing why
  - Uncertainty
- Design
  - Align goals
  - Collaboration
- Implementation
  - Soft solutions
    - Enable collaboration (demanded by dev and ops, facilitated by management)
    - Demand to fix/automate issues immediately
    - Use post-mortems to learn
    - Faster feedback loops
  - Technical solutions
    - CI/CD
    - Smaller, non-breaking changes
    - Telemetry
- Test
  - Economical impact
  - Psychological impact
- Conclusion
  - Collaboration
  - Holistic view
-->
