load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

cc_library(
    name = "workqueue",
    srcs = ["workqueue.c"],
    hdrs = ["workqueue.h"],
    linkopts = ["-pthread", "-levent"],
)

cc_binary(
    name = "server",
    srcs = ["server.c"],
    deps = [
        ":workqueue",
    ],
)

