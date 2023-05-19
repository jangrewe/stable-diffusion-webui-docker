# AUTOMATIC1111
Set the name of the Docker image:
```
export DOCKER_IMAGE=dcr.faked.org/stable-diffusion-webui:latest
```
Build the Docker image:
```
docker build -f Dockerfile.a1111 -t ${DOCKER_IMAGE} .
```
Run the Docker image:
```
docker run --gpus all --rm --name stable-diffusion -p 7860:7860 \
  -v /storage/stable-diffusion/extensions:/stable-diffusion-webui/extensions \
  -v /storage/stable-diffusion/embeddings:/stable-diffusion-webui/embeddings \
  -v /storage/stable-diffusion/models:/stable-diffusion-webui/models \
  -v /storage/stable-diffusion/outputs:/stable-diffusion-webui/outputs \
  -v /storage/stable-diffusion/cache:/root/.cache \
  ${DOCKER_IMAGE}
```
