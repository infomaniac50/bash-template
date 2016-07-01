#!/bin/bash

(
cat <<ENDOFSTRING
# when you run 'make' alone, run the 'css' rule (at the
# bottom of this makefile)
all: status

# .PHONY is a special command, that allows you not to
# require physical files as the target (allowing us to
# use the 'all' rule as the default target).
.PHONY: all

clean:
	git clean -Xdf -e \!src/vendor

clean-dev: clean
	rm -rf src/vendor/

push: prepare
	coder fix_perms
	coder push

delete: prepare
	coder fix_perms
	coder push --delete

status: prepare
	coder fix_perms
	coder status --delete

docker: prepare
	coder fix_perms
	/bin/bash iter.sh

autoload:
	cd src/ && composer dumpautoload

prepare: src/composer.lock src/vendor/autoload.php

src/vendor/autoload.php: src/composer.lock
	cd src/ && composer install

src/composer.lock: src/composer.json
	cd src/ && composer update
	touch src/vendor/autoload.php


ENDOFSTRING
) > Makefile
