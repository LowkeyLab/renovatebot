module.exports = {
  autodiscover: true,
  persistRepoData: true,
  branchPrefix: "lowkeylab-renovate/",
  platformCommit: "enabled",
  allowedUnsafeExecutions: ["bazelModDeps"],
  allowedCommands: ["REPIN=1 bazel run @maven//:pin", "bazel mod deps *", "multitool --lockfile tools/tools.lock.json update", "bazel run //tools:preset.update"],
};

