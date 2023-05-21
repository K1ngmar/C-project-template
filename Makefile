SETTINGS_DIR := make_settings

include $(SETTINGS_DIR)/src.mk
include $(SETTINGS_DIR)/settings.mk
include $(SETTINGS_DIR)/colors.mk

all: $(NAME)

# Compilation

$(NAME): $(LIBKM) $(OBJ)
	@echo "$(COLOR_GREEN)Creating $(NAME) executable...$(COLOR_RESET)"
	@$(CC) -o $@ $(OBJ) $(LIBKM_LIB) $(LFLAGS) $(CFLAGS)

-include $(DEPENDENCIES)

$(OBJ): $(ODIR)/%.o: $(SDIR)/%.c
	@mkdir -p $(@D)
	@echo "$(COLOR_LBLUE)Compiling...	$(COLOR_BLUE)$<$(COLOR_RESET)"
	@$(CC) -c -o $@ $< $(CFLAGS) -MMD -MP $(IFLAGS)

$(LIBKM):
	@$(MAKE) -C $(LIBKM_LOCATION)

# Clean up

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
	$(RM) -rf $(UNIT_BIN)
	@printf "$(COLOR_RESET)"

re: fclean
	@$(MAKE) re -C $(LIBKM_LOCATION)
	@$(MAKE) all

# Unit tests

$(UNIT_DIR)/bin/%: $(UNIT_DIR)/%.c
	@mkdir -p $(UNIT_DIR)/bin
	@echo "$(COLOR_LBLUE)Compiling tests... $(COLOR_BLUE)$<$(COLOR_RESET)"
	@$(CC) $(CFLAGS) $(IFLAGS) $< $(UNIT_OBJ) -o $@ -lcriterion $(LIBKM_LIB)

unit_test_build: $(NAME) $(UNIT_DIR) $(UNIT_BIN)

unit_test: unit_test_build
	@sh $(UNIT_DIR)/run_tests.sh

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

# Phony
.PHONY: debug fsanitize test clean fclean re
