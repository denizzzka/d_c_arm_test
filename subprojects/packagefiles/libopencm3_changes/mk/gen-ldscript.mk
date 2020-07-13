# Usage:
# $ make -f mk/generate-ldscript.mk generate DEVICE=stm32f103x8 OPENCM3_DIR=. RENAME_TO=somename.ld
# $ make -f mk/generate-ldscript.mk clean RENAME_TO=somename.ld

include $(OPENCM3_DIR)/mk/genlink-config.mk
include $(OPENCM3_DIR)/mk/gcc-config.mk
include $(OPENCM3_DIR)/mk/genlink-rules.mk

generate: $(LDSCRIPT)
	mv "$(LDSCRIPT)" "$(RENAME_TO)"

clean:
	$(Q)$(RM) "$(RENAME_TO)"
