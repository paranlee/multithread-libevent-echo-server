# Multithreaded, libevent-based socket server.

## Using nice libevent

Libevent is a nice library for handling and dispatching events, as well as doing nonblocking I/O.

This is fine, except that it is basically single-threaded.

## Do not under-utilize your computing resource

If you have multiple CPUs or a CPU with hyperthreading, 

you're really under-utilizing the CPU resources available to your server application.

Because your event pump is running in a single thread and therefore can only use one CPU core at a time.

## Event Queueing

The solution is to create one libevent event queues (AKA event_base) per active connection, 

each with its own event pump thread.  

This project does exactly that, 

giving you everything you need to write high-performance, multi-threaded, libevent-based socket servers.

There are mentionings of running libevent in a multithreaded implementation, 

however it is very difficult (if not impossible) to find working implementations.  

This project is a working implementation of a multi-threaded, libevent-based socket server.

# Build

Build output `server.o` is in `build` directory.

You can choose each build method.

## Build with bazel

Bazel look up `src/BUILD` file.

```console
foo@bar:~/multithread-libevent-echo-server$ bazel build //src:server
INFO: Analyzed target //src:server (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //src:server up-to-date:
  bazel-bin/src/server
INFO: Elapsed time: 0.121s, Critical Path: 0.00s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action
```

Then, copy executable file.

```console
foo@bar:~/multithread-libevent-echo-server$ cp bazel-bin/src/server build/server.o
```

## Build with Make

```console
foo@bar:~/multithread-libevent-echo-server$ make
```

## Using native CC

Go to src directory.

```console
foo@bar:~/multithread-libevent-echo-server$ cd src 
```

### GCC

```console
foo@bar:~/multithread-libevent-echo-server/src$ gcc -o ../build/server.o server.c workqueue.c -levent -lpthread
```

### clnag

```console
foo@bar:~/multithread-libevent-echo-server/src$ clang-12 -o ../build/server.o server.c workqueue.c -levent -lpthread
```

# Test Echo

## Run Server

Server running in port defined in server.c `[SERVER_PORT]`.

### Host server

```console
foo@bar:~/multithread-libevent-echo-server/build$./server.o
Server running in [SERVER_PORT]
```

### Run on Docker

Build Docker image.

```console
foo@bar:~/multithread-libevent-echo-server/$ podman build -t multithread-event-server .
```

Run container.

```console
foo@bar:~/multithread-libevent-echo-server/$ podman run -p 8080:8080 --name multithread-event-server multithread-event-server:latest
Server running in [SERVER_PORT]
```

## Run on host client

The server itself simply echoes whatever you send to it.  

Start it up, then telnet

```console
foo@bar:~/telnet localhost 8080
```

# License

Copyright (c) 2012 Ronald Bennett Cemer

This software is licensed under the BSD license.

See the accompanying LICENSE.txt for details.

# References

[Echoserver link](http://ishbits.googlecode.com/svn/trunk/libevent-examples/echo-server/libevent_echosrv1.c)

[Cliserver link](http://nitrogen.posterous.com/cliserver-an-example-libevent-based-socket-se)

[Bazel Build System with C](https://github.com/research-note/bazel-clang-c-example)
