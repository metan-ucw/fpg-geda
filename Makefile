all:
	$(MAKE) -C fp all
	$(MAKE) -C sym all

clean:
	$(MAKE) -C fp clean
	#$(MAKE) -C sym clean
