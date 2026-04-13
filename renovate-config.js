module.exports = {
  branchPrefix: "lowkeylab-renovate/",
  repositories: ["LowkeyLab/bazel-repo", "LowkeyLab/renovatebot"],
  platformCommit: true,
  allowedUnsafeExecutions: ["bazelModDeps"],
};

