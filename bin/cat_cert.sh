#!/usr/bin/env bash

if [[ $1 = '' || $1 = '-h' || $1 = '--help' || $2 = '' ]]; then
    cat << EOF
Usage: cat_cert.sh [-h] INPUT OUTPUT

Generates an SSL certificate file from PEM encoded cert and intermediate cert files.

  -h, --help  Show usage
  INPUT       File prefix for InCommon files (format: host_subdomain_oregonstate_edu)
  OUTPUT      Output prefix (format: host.subdomain.whatever)
EOF
    exit 0
fi

INPUT=$1
OUTPUT=$2.cer

cat ${INPUT}_cert.cer > $OUTPUT; echo "" >> $OUTPUT; cat ${INPUT}_interm.cer >> $OUTPUT
