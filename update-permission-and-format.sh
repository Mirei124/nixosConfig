#!/usr/bin/env bash

basedir='/etc/nix-darwin/'
# owner=${OWNER:-k}

find ${basedir} -exec chown connor:staff {} \+

find ${basedir} ! -path '*/.git*' -type f -name '*.nix' -exec alejandra {} \+
