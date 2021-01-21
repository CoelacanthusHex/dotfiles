#!/usr/bin/make -f

PREFIX = /usr
INSTALLDIR = $(DESTDIR)$(PREFIX)/share/katepart5/syntax
RM = rm -rf
INSTALL_STD = install -Dm644

install: local

clear:
	$(RM) $(INSTALLDIR)/ipfw.xml
	$(RM) $(INSTALLDIR)/nginx.xml
	$(RM) $(INSTALLDIR)/python.xml
	$(RM) $(INSTALLDIR)/smarty.xml
	$(RM) $(INSTALLDIR)/systemd.xml
	$(RM) $(INSTALLDIR)/vue.xml
	$(RM) $(INSTALLDIR)/yaml.xml

local:
	find . -name "*.xml" -type f -exec $(INSTALL_STD) '{}' "$(INSTALLDIR)/{}" \;

uninstall: clear
