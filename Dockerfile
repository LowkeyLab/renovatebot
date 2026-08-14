FROM ghcr.io/renovatebot/renovate:full@sha256:fde17bb5a0e8fde49b12c2d79e02f9ca9b91b98829e420e339306a9e66e2fe20

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
