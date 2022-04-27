# Autoscaling

- [Autoscaling](#autoscaling)
  - [Definition](#definition)
  - [Horizontal Pod Autoscaling](#horizontal-pod-autoscaling)
  - [References](#references)

## Definition

- There are two types of autoscaling: horizontal and vertical. Here, we'll only
  discuss horizontal autoscaling and include a reference later for vertical
  autoscaling.
- Horizontal autoscaling means a tool automatically increases or decreases the
  number of pods deployed based upon the workload the pods are undergoing.
- Horizontal autoscaling helps ensure that the your deployed resources meet the
  need of your workload.

## Horizontal Pod Autoscaling

- In Kubernetes, a *HorizontalPodAutoscaler* (HPA) automatically updates a workload
  resource with the aim of automatically scaling the workload to match
  demand.
- Horizontal scaling means that the response to increased load is to deploy
  more Pods **(referred to as replicas)**. This is different from vertical
  scaling, which for Kubernetes would mean assigning more resources
  (for example: memory or CPU) to the Pods that are already running for the
  workload.
- The *autoscaling* configuration values define how the HPA carries out this task.
- If the load decreases, and the number of Pods is above the configured
  minimum, the *HorizontalPodAutoscaler* instructs the workload resource
  to scale back down by reducing the number of deployed pods.

## References
<!-- markdownlint-disable-next-line MD013 -->
- [Kubernetes Horizontal Pod Autoscaling Reference](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
  <!-- markdownlint-disable-next-line MD013 -->
- [Kubernetes Horizontal Pod Autoscaler Reference (HPA)](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)
  <!-- markdownlint-disable-next-line MD013 -->
- [Horizontal vs Vertical Scaling](https://www.ibm.com/blogs/cloud-computing/2014/04/09/explain-vertical-horizontal-scaling-cloud/)
