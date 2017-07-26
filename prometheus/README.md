# Influitive Prometheus

This is a configuration for Prometheus that is intended for deployment in a
DC/OS cluster.  It uses the Marathon Service Discovery feature in Prometheus to
detect all running tasks that support prometheus metrics endpoints.

In order to enable your service you must add a label to each relevant
`portMappings` entry named `METRICS_PATH` whose value is the path to the metrics
endpoint (usually `/metrics`). Example:

```
"portMappings": [
  {
    "containerPort": 8080,
    "protocol": "tcp",
    "hostPort": 0,
    "labels": {
      "METRICS_PATH": "/metrics"
    }
  }
]
```
