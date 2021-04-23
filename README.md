# onnxruntime-arm

This runtime is compiled using a GitHub workflow, which runs in a self-hosted runner since the build time is longer than 6 hrs (maximum amount of time that a GitHub provided runner can be used).

Make sure the runner is up and configured before starting the build.

## self-hosted runner configuration

```sh

sudo apt update
sudo apt upgrade -y

# Install latest version of git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install git -y

# Install and setup docker
sudo apt install docker.io docker-compose -y
sudo systemctl enable docker
sudo gpasswd -a $USER docker
newgrp docker
usermod -aG docker $(whoami)

# Add current user to sudoer file
echo "${USER}  ALL=(ALL) NOPASSWD:ALL" | sudo tee "/etc/sudoers.d/${USER}"


# Configure as self-hosted runner
mkdir actions-runner && cd actions-runner

curl -o actions-runner-linux-x64-2.278.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.278.0/actions-runner-linux-x64-2.278.0.tar.gz

tar xzf ./actions-runner-linux-x64-2.278.0.tar.gz

sudo ./bin/installdependencies.sh

./config.sh --url https://github.com/pi-top/onnxruntime-arm --token <TOKEN>

# Configure runner as a systemd service
sudo ./svc.sh install
sudo ./svc.sh start
```
