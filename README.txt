# install docker CE from https://docs.docker.com/install/

# create a docker image from the Dockerfile (run this in the folder)
docker build -t labsec2 .

# run the image and get a shell
docker run -it labsec2 bash

## How to delete the image

# list images
docker images

# remove image
docker rmi -f <ID> # take the ID from the list above
