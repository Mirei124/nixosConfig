#!/usr/bin/env bash

set -euo pipefail

old=$(jq -r '.nodes.nixpkgs.locked.rev' flake.lock)
new=$(curl -sL 'https://prometheus.nixos.org/api/v1/query?query=channel_revision' | jq -r '.data.result[] | select(.metric.channel=="nixos-unstable") | .metric.revision')
nix-shell -p gnused --run "sed -i \"s#$old#$new#\" flake.nix"
echo "nixos-unstable: $old -> $new"

nix flake update
