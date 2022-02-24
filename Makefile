.PHONY: all install uninstall test build mo desktop metainfo
PREFIX ?= /usr
PO_LOCATION ?= po
LOCALE_LOCATION ?= /share/locale

all: gresource desktop metainfo build

build:
	TINY_APP_LOCALE_LOCATION="$(PREFIX)$(LOCALE_LOCATION)" $(CRYSTAL_LOCATION)shards build -Dpreview_mt --release --no-debug

test:
	$(CRYSTAL_LOCATION)crystal spec -Dpreview_mt --order random

gresource:
	glib-compile-resources --sourcedir data --target data/dev.geopjr.tinystats.gresource data/dev.geopjr.tinystats.gresource.xml

mo:
	mkdir -p $(PO_LOCATION)/mo
	for lang in `cat "$(PO_LOCATION)/LINGUAS"`; do \
		if [[ "$$lang" == 'en' || "$$lang" == '' ]]; then continue; fi; \
		mkdir -p "$(PREFIX)$(LOCALE_LOCATION)/$$lang/LC_MESSAGES"; \
		msgfmt "$(PO_LOCATION)/$$lang.po" -o "$(PO_LOCATION)/mo/$$lang.mo"; \
		install -D -m 0644 "$(PO_LOCATION)/mo/$$lang.mo" "$(PREFIX)$(LOCALE_LOCATION)/$$lang/LC_MESSAGES/dev.geopjr.tinystats.mo"; \
	done

metainfo:
	msgfmt --xml --template data/dev.geopjr.tinystats.metainfo.xml.in -d "$(PO_LOCATION)" -o data/dev.geopjr.tinystats.metainfo.xml

desktop:
	msgfmt --desktop --template data/dev.geopjr.tinystats.desktop.in -d "$(PO_LOCATION)" -o data/dev.geopjr.tinystats.desktop

install: mo
	install -D -m 0755 bin/tiny-stats $(PREFIX)/bin/tiny-stats
	install -D -m 0644 data/dev.geopjr.tinystats.desktop $(PREFIX)/share/applications/dev.geopjr.tinystats.desktop
	install -D -m 0644 data/icons/dev.geopjr.tinystats.svg $(PREFIX)/share/icons/hicolor/scalable/apps/dev.geopjr.tinystats.svg
	install -D -m 0644 data/icons/dev.geopjr.tinystats-symbolic.svg $(PREFIX)/share/icons/hicolor/symbolic/apps/dev.geopjr.tinystats-symbolic.svg
	gtk-update-icon-cache /usr/share/icons/hicolor

uninstall:
	rm -f $(PREFIX)/bin/tiny-stats
	rm -f $(PREFIX)/share/applications/dev.geopjr.tinystats.desktop
	rm -f $(PREFIX)/share/icons/hicolor/scalable/apps/dev.geopjr.tinystats.svg
	rm -f $(PREFIX)/share/icons/hicolor/symbolic/apps/dev.geopjr.tinystats-symbolic.svg
	rm -rf $(PREFIX)$(LOCALE_LOCATION)/*/*/dev.geopjr.tinystats.mo
	gtk-update-icon-cache /usr/share/icons/hicolor