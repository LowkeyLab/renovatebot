module.exports = {
  autodiscover: true,
  persistRepoData: true,
  branchPrefix: "lowkeylab-renovate/",
  platformCommit: "enabled",
  allowedUnsafeExecutions: ["bazelModDeps"],
  customEnvVariables: { ANDROID_HOME: "/opt/android-sdk" },
  allowedCommands: ["REPIN=1 bazel run @maven//:pin", "bazel mod deps *", "bazel run *"],
};

