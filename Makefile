CC = gcc
CFLAGS = -g -Wall
OBJS = echoserver_threaded.c workqueue.c
LDFLAGS = -levent -lpthread
TARGET = echoserver_threaded.out

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

clean:
	rm -f $(TARGET)
