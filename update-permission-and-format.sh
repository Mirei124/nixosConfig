#!/usr/bin/env bash

basedir='/etc/nixos/'
owner=${OWNER:-k}

find ${basedir} -exec chown ${owner}: {} \+

find ${basedir} ! -path '*/.git*' -type f -name '*.nix' -exec alejandra {} \+
