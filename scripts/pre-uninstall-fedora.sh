#!/bin/bash

set -e

dkms_name="hid-magictrackpad2"
dkms_version="4.10+hid-magictrackpad2"

if $(dkms status -m $dkms_name -v $dkms_version | egrep '(added|built|installed)' >/dev/null); then
    dkms remove $dkms_name/$dkms_version --all
fi

exit 0

