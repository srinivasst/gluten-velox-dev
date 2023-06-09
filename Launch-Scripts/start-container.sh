#!/bin/bash

# Check if the Docker container is running
if [ "$(docker start gluten-velox-oss-dev-box-Ubuntu20)" ]; then
    echo "Container gluten-velox-oss-dev-box-Ubuntu20 has been started."
else
    # If it's not running, show a message
    echo "Container gluten-velox-oss-dev-box-Ubuntu20 could not be started."
fi