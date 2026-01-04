FROM debian:unstable-slim
COPY requirements.txt .
RUN apt-get update && apt-get install -y curl build-essential python3 python3-pip python3-venv gcc-arm-none-eabi libnewlib-arm-none-eabi --no-install-recommends -y && curl -fsSL https://install.qmk.fm | CONFIRM=1 SKIP_CLEAN=1 UV_INSTALL_DIR=uv QMK_DISTRIB_DIR=qmk SKIP_QMK_FLASHUTILS=1 SKIP_PACKAGE_MANAGER=1 SKIP_UDEV_RULES=1 SKIP_WINDOWS_DRIVERS=1 SKIP_QMK_TOOLCHAINS=1 sh && apt-get purge curl --yes && apt-get autopurge --yes && apt-get clean autoclean && bash -c "rm -rf /var/lib/{apt,dpkg,cache,log}/" && /root/.local/share/uv/tools/qmk/bin/python -m pip install -r /requirements.txt && rm -R /requirements.txt && /uv/uv cache clean && pip cache purge
ENV PATH="/root/.local/bin:$PATH"
CMD ["qmk", "info"]