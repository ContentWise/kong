#!/bin/bash

set -ex

temp_dir=`mktemp -d`
release_name=`ls rate-limiting-failover* | sed 's/\(.*\)-[0-9].rockspec/kong-plugin-\1/'`
cp -r $(pwd) "$temp_dir/$release_name"
pushd $temp_dir
tar czvf "${release_name}.tar.gz" $release_name 
open .
