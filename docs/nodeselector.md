# NodeSelector

- [NodeSelector](#nodeselector)
  - [Definition](#definition)
  - [Example](#example)
  - [References](#references)

## Definition

- At times there is a need to allow a pod to be scheduled only on certain nodes
  in the cluster. The recommended form of the node selection constraint is to
  use a `nodeSelector`.
- The `nodeSelector` will specify the nodes with the `labels` that you wish to
  target.
- Once specified, Kubernetes will only schedule pods onto the nodes that have
  each of the `labels` specified.

## Example

Consider the following labels for 3 different nodes

```yaml
# node A
...
  labels:
    region: us-east-1
    type: system-node
```

```yaml
# node B
...
  labels:
    region: us-west-1
    type: app-node
```

```yaml
# node C
...
  labels:
    region: us-west-1
```

Now, suppose the following `nodeSelector` is configured:

```yaml
....

spec:
  nodeSelector: 
    region: us-west-1
    type: app-node
```

Only **node B** will meet the selection criteria because it has each
  label specified in the `nodeSelector`.

## References
<!-- markdownlint-disable-next-line MD013 -->
- [Kubernetes Assign Pods to Nodes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)
- [Kubernetes Node Selector User Guide](https://kubernetes.io/docs/user-guide/node-selection/)
