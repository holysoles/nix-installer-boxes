#!/bin/sh
echo "Checking presence of required commands for nix installer.."

cmd_list="tar xz sudo usermod"
for cmd in $cmd_list; do
	command -v "$cmd" > /dev/null
	if [ $? -ne 0 ]; then
		echo "$cmd not present!"
		exit 1
	fi
done

echo "success!"
