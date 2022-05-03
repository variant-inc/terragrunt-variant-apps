# Egress

- [Egress](#egress)
  - [Definition](#definition)
  - [When It Should Be Used](#when-it-should-be-used)
  - [Egress Configuration](#egress-configuration)
  - [References](#references)

## Definition

- From the perspective of the pod, egress is outgoing traffic from itself.
- The egress configuration allows customizing what external resources the
  service can connect to.
- [Istio](istio.md) is the tool used to help with this traffic management.
  <!-- markdownlint-disable-next-line MD013 -->
- Egress rules defined by the [egress configuration](#egress-configuration) help enforce traffic and can also be part of a [network policy](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

## When It Should Be Used

- It is common security best practice to restrict outgoing connections from the
  cluster.
- Egress rules should be configured when there are external services that your
  requires to properly function.

## Egress Configuration
<!-- markdownlint-disable MD013 -->
| Input | [Kubernetes Object Type](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/) | Description | Required | Default Value |
| - | - | - | - | - |
| istio.egress | ServiceEntry | A whitelist of external services that your API requires connection to. The whitelist applies to the entire namespace in which this chart is installed. [These services](https://github.com/variant-inc/iaac-eks/blob/master/scripts/istio/service-entries.eps#L8) are globally whitelisted and do not require declaration. | [ ] | [] |
| istio.egress[N].name | ServiceEntry | A name for this whitelist entry | [x] | |
| istio.egress[N].hosts | ServiceEntry | A list of hostnames to be whitelisted  | One or both istio.egress[N].hosts and istio.egress[N].addresses must be specified | [] |
| istio.egress[N].addresses | ServiceEntry | A list of IP addresses to be whitelisted | One or both istio.egress[N].hosts and istio.egress[N].addresses must be specified | [] |
| istio.egress[N].ports | ServiceEntry | A list of ports for the corresponding `istio.egress[N].hosts` or `istio.egress[N].addresses` to be whitelisted | [x] | [] |
| istio.egress[N].ports[M].number | ServiceEntry | A port number | [x] | |
| istio.egress[N].ports[M].protocol | ServiceEntry | Any of the protocols listed [here](https://istio.io/latest/docs/reference/config/networking/gateway/#Port) | [x] | |
<!-- markdownlint-enable -->
## References

- [Egress (k8s.networkop.co.uk)](https://k8s.networkop.co.uk/ingress/egress/)
- [What is Istio](https://cloud.google.com/learn/what-is-istio)
- [Istio docs](https://istio.io/latest/docs/)
