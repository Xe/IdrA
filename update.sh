#!/usr/bin/env nix-shell
#! nix-shell -p curl -p cacert -p jq -p niv -i bash

niv update zig -v $(curl https://ziglang.org/download/index.json | jq -r .master.version)
niv update
