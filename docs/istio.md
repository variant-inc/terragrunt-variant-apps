# Istio

- [Istio](#istio)
  - [Definition](#definition)
  - [How it Works](#how-it-works)
  - [What it Provides](#what-it-provides)
  - [References](#references)

## Definition

- [Istio](https://istio.io/latest/about/service-mesh/) is a service mesh that
  helps manage the microservices that make-up a cloud-native application. The
  service mesh supports how the microservices communicate.
- A service mesh is a dedicated infrastructure layer that you can add to your
  applications. It allows you to transparently add capabilities like
  observability, traffic management, and security, without adding them to your
  own code. The term "service mesh" describes both the type of software you use
  to implement this pattern, and the security or network domain that is created
  when you use that software.

## How it Works
  <!-- markdownlint-disable-next-line MD013 -->
- The [Istio documentation](https://istio.io/latest/about/service-mesh/#:~:text=it%20for%20you.-,How%20it%20Works,-Istio%20has%20two)
  explains that Istio has two components: the data plane and the control plane.
  <!-- markdownlint-disable-next-line MD013 -->
- Istio deploys an [Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/intro/what_is_envoy) along with each service in the cluster.
- The data plane is the communication between services, facilitated by the
  proxy in each service's pod.
- The control plane takes your desired configuration, and its view of the
  services, and dynamically programs the proxy servers, updating them as the
  rules or the environment changes.

## What it Provides

- Traffic management: traffic routing and control
- Security: authorization and authentication functionality
- Observability: telemetry and monitoring

## References

- [What is Istio](https://cloud.google.com/learn/what-is-istio)
- [Istio Docs](https://istio.io/latest/docs/)
