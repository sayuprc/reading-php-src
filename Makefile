BRANCH = PHP-8.3

define copy
	[ ! -f ${2} ] && { cp ${1} ${2}; :; } || { echo "Already exists: ${2}"; }
endef

.PHONY: clone
clone:
	@{ [ ! -d docker/php-src ]; } && { git clone --depth 1 --no-single-branch --branch ${BRANCH} https://github.com/php/php-src.git docker/php-src; :; } || { echo "Already exists docker/php-src"; }
	@{ [ ! -d docker/vld ]; } && { git clone https://github.com/derickr/vld.git docker/vld; :; } || { echo "Already exists: docker/vld"; }
	@echo "Done"

.PHONY: copy
copy:
	@$(call copy,.env.example,.env)
	@$(call copy,./docker/config.nice.example,./docker/config.nice)
	@$(call copy,./docker/installer.example,./docker/installer)
	@$(call copy,./docker/php.ini.example,./docker/php.ini)

.PHONY: build
build:
	@set -a \
		&& source ./.env \
		&& set +a \
		&& docker build -t reading-php-src:$${TAG} ./docker/
