 # Docker images

To be used in GitHub Actions and elsewhere.  Images are built by GH Actions and pushed to GH packages.  Serves as a reference for building and pushing images via GH Actions, and a reference for how to accomplish certain things in a docker image.

Goal is to be easy to describe images here, and to know I'll always have pre-built images.

Windows containers are indicated via an empty `is-windows` file and currently not built automatically.

Pushing windows images requires `--allow-nondistributable-artifacts` to be set in daemon options.
See also: https://docs.docker.com/engine/reference/commandline/dockerd/
https://medium.com/@amlys/solution-docker-push-fails-with-skipping-foreign-layer-a119e03bdf0d

```
"allow-nondistributable-artifacts": [
  "docker.pkg.github.com:443"
]
```