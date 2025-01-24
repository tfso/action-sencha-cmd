#!/bin/sh -l

cd $1

echo "$2" | while IFS= read -r cmd
do
    [ -z "$cmd" ] && continue
    /opt/Sencha/Cmd/sencha $cmd
done
