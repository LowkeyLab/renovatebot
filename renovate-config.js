module.exports = {
   branchPrefix: "lowkeylab-renovate/",
   repositories: ["LowkeyLab/bazel-repo", "LowkeyLab/renovatebot"],
   platformCommit: "enabled",
   allowedUnsafeExecutions: ["bazelModDeps"],
  allowedCommands: ["REPIN=1 bazel run @maven//:pin"],
};

