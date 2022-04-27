# Tolerations

- [Tolerations](#tolerations)
  - [Definition](#definition)
  - [Example](#example)
  - [References](#references)

## Definition

- Tolerations and taints work together. A taint is a condition on a cluster
  node that disallows pods to be scheduled on the node unless the pod has a
  toleration for the particular taint.

## Example

Suppose the following 3 pods have `tolerations` configured as follows and
  that all 3 pods are are currently on nodeA.

```yaml
#podA
tolerations:
  - effect: NoSchedule
    key: "node.kubernetes.io/memory-pressure"
    operator: "Exists"
```

```yaml
#podB
tolerations:
  - effect: NoSchedule
    key: "node.kubernetes.io/network-unavailable"
    operator: "Exists"
```

```yaml
#podC
# no tolerations defined
```

Now, suppose nodeA has the `node.kubernetes.io/memory-pressure` taint with
the `NoSchedule` effect.

Then, podB and podC will be evicted from the node and only podA will remain.

## References
<!-- markdownlint-disable-next-line MD013 -->
- [Kubernetes Taints and Tolerations Reference](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
