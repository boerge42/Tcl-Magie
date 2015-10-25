TARGET  = libfac
OUT     = $(TARGET).so
CC      = gcc
CFLAGS  = -shared
CFLAGS += -fPIC
;CFLAGS += -DUSE_TCL_STUBS -ltclstub8.6
CFLAGS += -I/usr/include/tcl8.6


all: $(TARGET)

$(TARGET): $(TARGET).c
	$(CC) $(CFLAGS) -o $(TARGET).so $? 

clean::
	rm -f $(TARGET).so

.PHONY: clean
