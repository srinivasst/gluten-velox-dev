# gluten-velox-dev
This repo contains scripts and docker image to immediately start gluten / velox development.

## Step 0. First time localbox / VM setup

```
sudo ./Setup-Scripts/vm-setup.sh
```

This [script](Setup-Scripts/vm-setup.sh) will setup docker and X11 server and client for running GUI apps on the Docker container.

## Step 1. Start container

```
sudo ./Launch-Scripts/run.sh
```

This will start the container using the following image from Docker Hub: [srinivasst/gluten-velox-oss:ubuntu20](https://hub.docker.com/layers/srinivasst/gluten-velox-oss/ubuntu20/images/sha256-552c3b96f7178046831584307dd4c84b2d1595a452a0fa9a73580ecfb1f23009)

## Step 2. Launch Applications in Docker

| Action | Command |
| - | - |
| Start **bash** inside container | `sudo ./Launch-Scripts/bash.sh` |
| Start **IntelliJ** inside container | `sudo ./Launch-Scripts/idea.sh` |
| Start **CLion** inside container | `sudo ./Launch-Scripts/clion.sh` |

## Other usefull scripts

| Action | Command |
| - | - |
| Stop Container (Will stop container but can be started again. Progress will not be lost.) | `sudo ./Launch-Scripts/stop-container.sh` |
| Start Container (Will start container that was stopped.) | `sudo ./Launch-Scripts/start-container.sh` |
| Remove Container (Will permanently delete container. **Progress will be lost.**) | `sudo ./Launch-Scripts/remove-container.sh` |

Stop and Start scripts can be used to restart container when facing issues. Remove should be used when the cotnainer is no longer needed as it will delete all data saved in the container.