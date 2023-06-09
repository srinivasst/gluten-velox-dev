#!/bin/bash

# Check if the Docker container is running
if [ "$(docker ps -q -f name=gluten-velox-oss-dev-box-Ubuntu20)" ]; then
    # If it is, stop the Docker container
    docker stop gluten-velox-oss-dev-box-Ubuntu20
    echo "Container gluten-velox-oss-dev-box-Ubuntu20 has been stopped."
else
    # If it's not running, show a message
    echo "Container gluten-velox-oss-dev-box-Ubuntu20 is not running."
fi
