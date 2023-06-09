#!/bin/bash

docker run -d -e DISPLAY=${DISPLAY} -v $HOME/.Xauthority:/root/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix --network=host --privileged --name gluten-velox-oss-dev-box-Ubuntu20 srinivasst/gluten-velox-oss:ubuntu20