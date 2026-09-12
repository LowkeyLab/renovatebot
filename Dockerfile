FROM ghcr.io/renovatebot/renovate:full@sha256:53be5fbf5e70c1567a40ef1d1c3709ec7f6d7f4d98bb679395dd4fb8dc890228

ARG ANDROID_API_LEVEL=35
ARG ANDROID_BUILD_TOOLS_VERSION=35.0.0

# Keep the SDK and Android CLI runtime outside /tmp: renovatebot/github-action
# mounts the runner's /tmp over the container path, hiding containerbase caches.
ENV ANDROID_HOME=/opt/android-sdk

USER root

RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
        -o /etc/apt/keyrings/google.asc \
    && echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google.asc] https://dl.google.com/android/cli/latest/debian/ stable main" \
        > /etc/apt/sources.list.d/android-cli.list \
    && apt-get update \
    && apt-get install --no-install-recommends --yes android-cli \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f /home/ubuntu/.android \
    && install -d -o 12021 -g 0 /home/ubuntu/.android \
    && mkdir -p "${ANDROID_HOME}" \
    && chown -R 12021:0 "${ANDROID_HOME}"

USER 12021

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN android --no-metrics --version \
    && android --no-metrics --sdk="${ANDROID_HOME}" sdk install \
        "platform-tools" \
        "platforms/android-${ANDROID_API_LEVEL}" \
        "build-tools/${ANDROID_BUILD_TOOLS_VERSION}" \
    && test -f "${ANDROID_HOME}/platforms/android-${ANDROID_API_LEVEL}/android.jar" \
    && test -x "${ANDROID_HOME}/platform-tools/adb" \
    && test -x "${ANDROID_HOME}/build-tools/${ANDROID_BUILD_TOOLS_VERSION}/aapt"
