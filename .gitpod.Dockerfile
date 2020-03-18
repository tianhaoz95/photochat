FROM gitpod/workspace-full

ENV FLUTTER_VERSION="v1.12.13+hotfix.8-stable"

RUN mkdir -p /home/gitpod/development && \
  cd /home/gitpod/development && \
  wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}.tar.xz && \
  tar -xf ./flutter_linux_${FLUTTER_VERSION}.tar.xz && \
  echo "export PATH=\"\$PATH:/home/gitpod/development/flutter/bin\"" >> ~/.bashrc && \
  echo "export PATH=\"\$PATH:/home/gitpod/development/flutter/bin/cache/dart-sdk/bin/\"" >> ~/.bashrc && \
  echo "export PATH=\"\$PATH:/home/gitpod/.pub-cache/bin\"" >> ~/.bashrc
