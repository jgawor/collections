
1. Deploy pipeline
```
oc apply -f tekton/collections-build-task.yaml
```

1. Configure build
Update the `tekton/collections-build-task-run.yaml` with information about your cluster.

1 Trigger build
```
oc delete --ignore-not-found -f tekton/collections-build-task-run.yaml; sleep 5; oc apply -f tekton/collections-build-task-run.yaml
```
