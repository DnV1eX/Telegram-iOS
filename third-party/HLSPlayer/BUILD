load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "HLSPlayer",
    module_name = "HLSPlayer",
    srcs = glob([
		"HLSPlayer/Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [],
    visibility = [
        "//visibility:public",
    ],
)
