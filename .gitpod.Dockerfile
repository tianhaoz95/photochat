FROM gitpod/workspace-full

RUN mkdir -p /home/gitpod/development && \
  cd /home/gitpod/development && \
  wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.12.13+hotfix.7-stable.tar.xz && \
  tar -xf ./flutter_linux_v1.12.13+hotfix.7-stable.tar.xz && \
  echo "export PATH=\"\$PATH:/home/gitpod/development/flutter/bin\"" >> ~/.bashrc
