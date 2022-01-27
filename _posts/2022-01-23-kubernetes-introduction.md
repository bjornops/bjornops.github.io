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
**(todo: find container articles)**
The main concept is that you create an environment in which your application runs and the environment contains all the dependencies that the app needs to run.
Without any intervene from Operations, you can use, upgrade and run multiple versions of dotnet, java, python, etc. without them interfering with each other.

## Case

Instead of explaining abstractly how the most relevant components of Kubernetes works, I'm going to use a concrete example.

Beneath you can see a figure that is an overview of the hardware involved in a hypothetical, already existing solution.
It's a low-to-medium complex solution, but will suffice to demonstrate the capabilities of Kubernetes.

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/case.png){: .align-center width="90%" }
*The architecture we want to mimic in our Kubernetes solution.*

At the left hand side, we have our consumer.
The consumer can either be a business using our APIs, or a customer viewing our UI.
Either way, they're entering through our loadbalancer, the green square with the arrows within, that distributes the traffic according to the URL and current load on the servers within the target group.

Both the `Frontend` and `Backend` groups use an `Internal` service that is not eligible for public exposure, also covered by a loadbalancer.

To ensure that all the different types of services are available at all times, they are running across two servers respectively.
That totals six servers.

With that case explained, let's get to Kubernetes!

## Kubernetes

To solve this case, I'll go bottom-up, starting at the simplest topics and building gradually more until we reach a satisfying solution.
The simplest part here is our applications, hosted in their containers.

### Pods

In Kubernetes, Pods are the instances of your application, and just an encapsulation of the containers that I described introductory.

The pod also enables you to run multiple containers, but we'll let that be an advanced topic for those interested.

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/kubernetes-pod.png){: .align-center}
*A pod. In this case with just one container*

We now have a basis for running our application, and this could technically be deployed to Kubernetes, so let's.

### Node

Of course an application isn't worth much by itself, it needs some hardware to run.
That is also true for Kubernetes.
Here, the computers that host your applications are called nodes.

This is the most technical I'll go into the workings of Kubernetes in this article, so bear with me.
In order to be a Kubernetes Node, there are two requirements:

1) Run a container runtime (Docker, containerd, etc.)
2) Run some Kubernetes tools.

The first requirement is sort of self explanatory.
For a server (or any computer) to run containers, it needs a container runtime.

However, for Kubernetes to orchestrate the machines part of its cluster, it needs a couple of instruments.

The Kubelet is necessary for maintaining the containers running on its node, including spawning new, stopping or restarting them.
The Kube proxy enables the containers to communicate with containers that run on other nodes in the cluster, thus the kube-proxy works as a sort of relay.

<!-- Todo: Include kernel? -->

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/kubernetes-node.png){: .align-center width="75%"}
*A Kubernetes node*

So now we have a pod and a node to run it.

*Todo: transition*

### Service

A *service* enables other components of the cluster to utilize the application we have running in our pod.
It serves as a connectivity layer, and makes the pod or pods that it covers available in the Kubernetes network.
Now, if any other pod wants to connect to our application, it can use the service name as a URL.
The Kubernetes DNS together with the Kube proxy will guide the traffic to our pod.

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/kubernetes-service.png){: .align-center width="75%"}
*A service with two pods*

Pod A and B in the figure can be running the same application or different ones, but you would be best served providing only one application, as the traffic could be directed to either one of them.
So for a consistent experience, please use replicas of the same pod.

### Ingress

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/kubernetes-ingress.png){: .align-center width="75%"}
*An ingress that points to a single service*

### Namespace

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/kubernetes-namespace.png){: .align-center width="75%"}
*A namespace covering two services, X and Y.*

### Case solution

{: .text-center}
![Figure](/assets/posts/2022-kubernetes-intro/kubernetes-applied-architecture.png){: .align-center width="75%"}
*A solution for the aforementioned case*

## Evaluating Kubernetes

Kubernetes is a great tool for container orchestration.
However, that does not mean it is a great solution for everything.

Kubernetes is best suited for stateless and horizontally scalable applications, especially with fluctuating traffic or load.
One of the best, and thankfully most used, case is web applications, e.g. APIs, websites, etc.

Other applications, such as machine learning tasks that have special hardware requirements, offline programs and games are not well suited for running in a Kubernetes cluster.

## Resources

- *Kubernetes Documentation* - [Kubernetes](https://kubernetes.io/docs/home/)
