# Stable Diffusion WebUI in Docker

This builds a Docker image containing the Stable Diffusion WebUI by AUTOMATIC111 from https://github.com/AUTOMATIC1111/stable-diffusion-webui

## Build the image (and optionally push it to your registry)
Set the version and image name to use:
```
export VERSION="1.3.2"
export IMAGE_NAME=registry.example.com/stable-diffusion-webui
```
Build the image and also add the `latest` tag:
```
docker build --build-arg VERSION=${VERSION} -t ${IMAGE_NAME}:${VERSION} .
docker tag ${IMAGE_NAME}:${VERSION} ${IMAGE_NAME}:latest
```
Optionally, push both tags to your registry:
```
docker push ${IMAGE_NAME}:${VERSION}
docker push ${IMAGE_NAME}:latest
```

## Run the container
Run the image without retaining any data or outputs on exit:

```
docker run --gpus all --rm --name stable-diffusion -p 7860:7860 ${IMAGE_NAME}:latest
```

Run the image with persisted models, downloaded data and outputs:
```
docker run --tty --gpus all --rm --name stable-diffusion-webui -p 7860:7860 \
  -v /storage/stable-diffusion/data/:/app/data \
  -v /storage/stable-diffusion/repositories:/app/repositories \
  -v /storage/stable-diffusion/cache:/root/.cache \
  -v /storage/stable-diffusion/outputs:/app/outputs \
  ${IMAGE_NAME}:latest
```

# Troubleshooting
* There is no output to the console when starting the image until you generate an image.
  This can be fixed by adding the `--tty` argument after `docker run`
