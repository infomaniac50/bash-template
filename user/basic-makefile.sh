#!/bin/bash

(
cat <<ENDOFSTRING
# when you run 'make' alone, run the 'css' rule (at the
# bottom of this makefile)
all: build

# .PHONY is a special command, that allows you not to
# require physical files as the target (allowing us to
# use the 'all' rule as the default target).
.PHONY: all

clean:
	git clean -Xdf

build:
	/bin/true

install: build
	/bin/true

ENDOFSTRING
) > Makefile
