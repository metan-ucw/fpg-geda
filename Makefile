all:
	@cd lib && $(MAKE)
	@cd components && $(MAKE)
	@cd scripts && $(MAKE)

clean:
	@cd lib && $(MAKE) clean
	@cd components && $(MAKE) clean
	@rm -rf footprints && mkdir footprints 
