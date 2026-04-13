module.exports = {
   branchPrefix: "lowkeylab-renovate/",
   repositories: ["LowkeyLab/bazel-repo", "LowkeyLab/renovatebot", "LowkeyLab/gradle-build-scan-server"],
   platformCommit: "enabled",
   allowedUnsafeExecutions: ["bazelModDeps"],
  allowedCommands: ["REPIN=1 bazel run @maven//:pin"],
};

