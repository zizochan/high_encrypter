#!/bin/sh

abspath=$(cd $(dirname $0) && pwd)
exec ruby "$abspath/lib/decrypt.rb" "$@"
