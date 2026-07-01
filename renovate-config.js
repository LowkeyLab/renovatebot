module.exports = {
  autodiscover: true,
  persistRepoData: true,
  branchPrefix: "lowkeylab-renovate/",
  platformCommit: "enabled",
  allowedUnsafeExecutions: ["bazelModDeps"],
  allowedCommands: [
    "REPIN=1 bazel run @maven//:pin",
    "env -u ANDROID_HOME REPIN=1 bazel run @maven//:pin *",
    "bazel mod deps *",
    "bazel run *",
  ],
};

