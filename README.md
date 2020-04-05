Docker images to be used in GitHub Actions and elsewhere.

Windows containers are indicated via an empty `is-windows` file.

Pushing windows images requires `--allow-nondistributable-artifacts` to be set in daemon options.
See also: https://docs.docker.com/engine/reference/commandline/dockerd/
https://medium.com/@amlys/solution-docker-push-fails-with-skipping-foreign-layer-a119e03bdf0d

```
"allow-nondistributable-artifacts": [
  "docker.pkg.github.com:443"
]
```