SETTINGS_DIR := make_settings

include $(SETTINGS_DIR)/src.mk
include $(SETTINGS_DIR)/settings.mk
include $(SETTINGS_DIR)/colors.mk

all: $(NAME)

# Compilation
$(NAME): $(LIBKM) $(OBJ)
	@echo "$(COLOR_GREEN)Creating $(NAME) executable...$(COLOR_RESET)"
	@$(CXX) -o $@ $(OBJ) $(LIBKM_LIB) $(LFLAGS) $(CFLAGS)

$(OBJ): $(ODIR)/%.o: $(SDIR)/%.c
	@mkdir -p $(@D)
	@echo "$(COLOR_LBLUE)Compiling...	$(COLOR_BLUE)$<$(COLOR_RESET)"
	@$(CC) -c -o $@ $< $(CFLAGS) $(IFLAGS)

$(LIBKM):
	@$(MAKE) -C $(LIBKM_LOCATION)

# Clean up
.PHONY: clean fclean re

clean:
	@echo "$(COLOR_YELLOW)clean $(NAME)... $(COLOR_RESET)"
	@$(MAKE) clean -C $(LIBKM_LOCATION)
	@printf "$(COLOR_RED)"
	$(RM) -r $(ODIR)
	@printf "$(COLOR_RESET)"

fclean: clean
	@echo "$(COLOR_YELLOW)force clean $(NAME)... $(COLOR_RESET)"
	@$(MAKE) fclean -C $(LIBKM_LOCATION)
	@printf "$(COLOR_RED)"
	$(RM) $(NAME)
	@printf "$(COLOR_RESET)"

re: fclean
	@$(MAKE) re -C $(LIBKM_LOCATION)
	@$(MAKE) all

# phony
.PHONY: debug fsanitize

# Debugging
debug: fclean
	@echo "$(COLOR_YELLOW)Building $(NAME) debug... $(COLOR_RESET)"
	@$(MAKE) debug -C $(LIBKM_LOCATION)
	@$(MAKE) DEBUG=1

leaks: fclean
	@echo "$(COLOR_YELLOW)Building $(NAME) leaks... $(COLOR_RESET)"
	@$(MAKE) leaks -C $(LIBKM_LOCATION)
	@$(MAKE) LEAKS=1

fsanitize: fclean
	@echo "$(COLOR_YELLOW)Building $(NAME) fsanitize... $(COLOR_RESET)"
	@$(MAKE) fsanitize -C $(LIBKM_LOCATION)
	@$(MAKE) FSANITIZE=1
