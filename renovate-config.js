module.exports = {
  autodiscover: true,
  persistRepoData: true,
  branchPrefix: "lowkeylab-renovate/",
  platformCommit: "enabled",
  allowedUnsafeExecutions: ["bazelModDeps"],
  allowedCommands: ["REPIN=1 bazel run @maven//:pin"],
};

