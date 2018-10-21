#!/bin/bash

# assign variables
ACTION=${1:-default}
version=0.5.0

function show_version()
{
echo $version
}

function create_file()
{
curl http://169.254.169.254/latest/dynamic/instance-identity/document/ > backend1-identity.json
curl -vs https://s3.amazonaws.com/seis665/message.json 2>&1 | tee backend1-message.txt
sudo cp /var/log/nginx/access.log ./
}

function display_help()
{


cat << EOF
Usage: ${0} {-c|--create|-h|--help|-v|--version} 

OPTIONS: 
	-c| --create run curl and save json
	-h | --help Display the command help
	-v | --version Display the version

Examples:

	Display help:
		$ ${0} -h

	Display the version:
		$ ${0} -v

EOF
}

case "$ACTION" in 
	-default)
		display_help
		;;
	-c|--create)
		create_file
		;;
	-h|--help)
		display_help
		;;
	-v|--version)
		show_version
		;; 
	*)
	echo "Usage ${0} {-c|-h|-v}"
	exit 1
esac
