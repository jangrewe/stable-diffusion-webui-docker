# Stable Diffusion WebUI in Docker

## Available Versions
Set the version of the Docker image you want to build:

#### AUTOMATIC1111:
To build the Stable Diffusion WebUI by AUTOMATIC111 from https://github.com/AUTOMATIC1111/stable-diffusion-webui
```
export IMAGE_VERSION="automatic1111"
```
#### Vlad
To build the Stable Diffusion WebUI by Vlad Mandic from https://github.com/vladmandic/automatic/
```
export IMAGE_VERSION="vlad"
```

## Build the image (and optionally push it to your registry)
```
export IMAGE_NAME=registry.example.com/stable-diffusion-webui:${IMAGE_VERSION}
docker build -f Dockerfile.${IMAGE_VERSION} -t ${IMAGE_NAME} .
docker push ${IMAGE_NAME}
```

## Run the container
Run the image without retaining any data or outputs on exit:

```
docker run --gpus all --rm --name stable-diffusion -p 7860:7860 ${IMAGE_NAME}
```

Run the image with persisted models, downloaded data and outputs:
```
docker run --tty --gpus all --rm --name stable-diffusion -p 7860:7860 \
  -v /storage/stable-diffusion/data/${IMAGE_VERSION}:/app/data \
  -v /storage/stable-diffusion/repositories:/app/repositories \
  -v /storage/stable-diffusion/cache:/root/.cache \
  -v /storage/stable-diffusion/outputs:/app/outputs \
  ${IMAGE_NAME}
```

# Troubleshooting
* There is no output to the console when starting the AUTOMATIC1111 image until you generate an image.
  This can be fixed by adding the `--tty` argument after `docker run`
* The Vlad image asks you to confirm the download of the default model if it doesn't find one (e.g. because you mounted an empty data directory, or ran the image without a mounted data directory).
  If that happens, the container will exit with an error, as you can't confirm the download.
  To fix this, run the container with the `--interactive` argument after `docker run`, then you can confirm the download.
  If you are using a moounted data directory, this should only be necessary for the first run, as it will find the downloaded model the next time you start the image.
