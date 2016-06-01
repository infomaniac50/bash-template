# when you run 'make' alone, run the 'css' rule (at the
# bottom of this makefile)
all: build

# .PHONY is a special command, that allows you not to
# require physical files as the target (allowing us to
# use the 'all' rule as the default target).
.PHONY: all

PREFIX="/usr/local/bin"

clean:
	git clean -Xdf

build:
	@/bin/true

install: build $(PREFIX)/template $(PREFIX)/new

uninstall:
	rm $(PREFIX)/template
	rm $(PREFIX)/new

$(PREFIX)/template:
	ln -sr template.sh $(PREFIX)/template

$(PREFIX)/new:
	ln -sr template.sh $(PREFIX)/new
