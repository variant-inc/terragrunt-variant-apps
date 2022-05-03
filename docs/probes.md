# Probes

- [Probes](#probes)
  - [Definition](#definition)
  - [Types](#types)
    - [livenessProbe](#livenessprobe)
    - [readinessProbe](#readinessprobe)
    - [startupProbe](#startupprobe)
  - [References](#references)

## Definition

- A diagnostic performed periodically on a container to check for startup,
   readiness, or liveness.

## Types

### livenessProbe

- Indicates whether the container is running.
- If the liveness probe fails, the container is killed, and the container is
  subjected to its restart policy.
- If a container does not provide a liveness probe, the default state is
  `Success`.
- Use a livenessProbe if you'd like your container to be killed and restarted
  if a probe fails.

### readinessProbe

- Indicates whether the container is ready to respond to requests.
- If the readiness probe fails, the endpoints controller removes the Pod's IP
  address from the endpoints of all Services that match the Pod.
- The default state of readiness before the initial delay is `Failure`.
- If a container does not provide a readiness probe, the default state is
   `Success`.
- Use a readinessProbe if you'd like to start sending traffic to a Pod **only**
  when a probe succeeds.

### startupProbe

- Indicates whether the application within the container is started.
- All other probes are disabled if a startup probe is provided, until it succeeds.
- If the startup probe fails, the container is killed, and the container is
  subjected to its restart policy.
- If a container does not provide a startup probe, the default state is `Success`.
- Use a startupProbe if your containers take a long time to come into service.

## References
<!-- markdownlint-disable-next-line MD013 -->
- [Kubernetes Probes](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)
  <!-- markdownlint-disable-next-line MD013 -->
- [Configuring Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
  <!-- markdownlint-disable-next-line MD013 -->
- [Kubernetes Probes Documentation](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#Probe)
