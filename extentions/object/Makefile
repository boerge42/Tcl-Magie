TARGET  = libcounter
OUT     = $(TARGET).so
CC      = gcc
CFLAGS  = -shared
CFLAGS += -fPIC
; CFLAGS += -DUSE_TCL_STUBS -ltclstub
CFLAGS += -I/usr/include/tcl


all: $(TARGET)

$(TARGET): $(TARGET).c
	$(CC) $(CFLAGS) -o $(TARGET).so $? 

clean::
	rm -f $(TARGET).so

.PHONY: clean
