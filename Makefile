
MKREG  = perl mkreg.pl
RM     = rm -fv
CURDIR = 

all: doc/menuitems-add.reg doc/menuitems-remove.js

menuitems-add.reg:
	$(MKREG) $(CURDIR) > $@
menuitems-remove.js:
	$(MKREG) --remove $(CURDIR) > $@

doc/menuitems-add.reg: menuitems-add.reg
	mv $< doc/
doc/menuitems-remove.js: menuitems-remove.js
	mv $< doc/

clean:
	$(RM) *~ *.BAK .*.BAK
	$(RM) menuitems-add.reg menuitems-remove.js
	$(RM) doc/*~ doc/*.BAK doc/.*.BAK
	#$(RM) doc/menuitems-add.reg doc/menuitems-remove.js
