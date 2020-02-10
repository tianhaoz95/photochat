FROM gitpod/workspace-full

RUN sudo mkdir -p /development && \
  cd /development && \
  sudo wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.12.13+hotfix.7-stable.tar.xz && \
  sudo tar -xf ./flutter_linux_v1.12.13+hotfix.7-stable.tar.xz && \
  sudo echo "export PATH=\"\$PATH:/development/flutter/bin\"" >> ~/.bashrc
