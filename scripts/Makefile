all: do_enter gen_jamicon gen_talema gen_heat_sinks gen_connectors gen_TO220 gen_DIP gen_resistor gen_diode gen_cap do_leave

do_enter:
	@echo -e "\n*** Generating symbols ***"

do_leave:
	@echo -e "\n*** Footprints generated ***\n"
	@echo -e "-- Have a fun!\n"

gen_jamicon:
	@echo
	@./gen_jamicon_sk.sh
	@echo
	@./gen_jamicon_large_can.sh

gen_talema:
	@echo
	@./gen_talema_coils.sh

gen_heat_sinks:
	@echo
	@./gen_heat_sinks.sh

gen_connectors:
	@echo
	@./gen_connectors.sh

gen_TO220:
	@echo
	@./gen_TO220.sh

gen_DIP:
	@echo
	@./gen_DIP.sh

gen_resistor:
	@echo
	@./gen_resistor.sh

gen_diode:
	@echo
	@./gen_diode.sh

gen_cap:
	@echo
	@./gen_cap.sh
