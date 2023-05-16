ifndef SETTINGS_MK
SETTINGS_MK = 1

NAME	= ${REPOSITORY_NAME}

CFLAGS	= -Wall -Wextra -Werror -O3
IFLAGS	= $(addprefix -I, $(IDIR))

SDIR	= src
ODIR	= .obj
IDIR	= includes libkm/includes

ifdef DEBUG
	CFLAGS += -g -D DEBUG
endif

ifdef LEAKS
	CFLAGS += -D LEAKS
endif

ifdef FSANITIZE
	CFLAGS += -D FSANITIZE
	CFLAGS += -g -fsanitize=address
endif

include ./make_settings/src.mk
OBJ := $(addprefix $(ODIR)/, $(SRC:.c=.o))

endif
