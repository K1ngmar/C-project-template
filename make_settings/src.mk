ifndef SRC_MK
SRC_MK = 1

SRC := main.c \
	   utility/some-file.c

LIBKM_LOCATION = libkm/
LIBKM = $(LIBKM_LOCATION)libkm.a
LIBKM_LIB = -L$(LIBKM_LOCATION) -lkm

endif
