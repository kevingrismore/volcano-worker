# Volcano Worker

To use the `volcano` worker type defined in this repository, complete the following steps:

1. Install the Volcano in your cluster using its [Helm chart](https://volcano.sh/en/docs/installation/#install-with-helm)
2. Build and push an image to your registry using the the included Dockerfile.
3. Use the [prefect-worker](https://github.com/PrefectHQ/prefect-helm/tree/main/charts/prefect-worker) Helm chart to create the necessary resources in your Kubernetes cluster. Override defaults in the chart using a `values.yaml`.

```yaml
namespaceOverride: <your-namespace> # must not be volcano-system

worker:
  cloudApiConfig:
    accountId: <your-account-id>
    workspaceId: <your-workspace-id>
  config:
    workPool: volcano # or any valid work pool name not currently in use
  image:
    repository: <your-registry/your-image>
    prefectTag: <your-image-tag>

role:
  extraPermissions:
    - apiGroups:
        - batch.volcano.sh
      resources:
        - jobs
      verbs:
        - "get"
        - "list"
        - "watch"
        - "create"
        - "update"
        - "patch"
        - "delete"
```

Once your `VolcanoWorker` is running, a new `Volcano` type work pool should appear in your workspace, ready to run deployments!