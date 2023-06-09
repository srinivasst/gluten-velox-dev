#!/bin/bash

# Check if the Docker container exists
if [ "$(docker ps -a -q -f name=gluten-velox-oss-dev-box-Ubuntu20)" ]; then
    # If it does, remove the Docker container
    docker rm -f gluten-velox-oss-dev-box-Ubuntu20
    echo "Container gluten-velox-oss-dev-box-Ubuntu20 has been removed."
else
    # If it doesn't exist, show a message
    echo "Container gluten-velox-oss-dev-box-Ubuntu20 does not exist."
fi
