FROM ghcr.io/renovatebot/renovate:full

ARG ANDROID_API_LEVEL=35
ARG ANDROID_BUILD_TOOLS_VERSION=35.0.0

# Keep the SDK outside /tmp: renovatebot/github-action mounts the runner's /tmp
# over the container path, which would otherwise hide containerbase's SDK cache.
ENV ANDROID_HOME=/opt/android-sdk

USER root

RUN install-tool android-sdk-cmdline-tools \
    && mkdir -p "${ANDROID_HOME}" \
    && chown -R 12021:0 "${ANDROID_HOME}"

USER 12021

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN (set +o pipefail; yes | sdkmanager --licenses >/dev/null) \
    && sdkmanager --install \
        "platform-tools" \
        "platforms;android-${ANDROID_API_LEVEL}" \
        "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    && test -f "${ANDROID_HOME}/platforms/android-${ANDROID_API_LEVEL}/android.jar" \
    && test -x "${ANDROID_HOME}/platform-tools/adb" \
    && test -x "${ANDROID_HOME}/build-tools/${ANDROID_BUILD_TOOLS_VERSION}/aapt"
