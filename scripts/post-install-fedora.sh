#!/bin/bash

set -e

dkms_name="hid-magictrackpad2"
dkms_version="4.10+hid-magictrackpad2"

if ! $(dkms status -m $dkms_name -v $dkms_version | egrep '(added|built|installed)' > /dev/null); then
    dkms add -m $dkms_name -v $dkms_version
fi

if ! $(dkms status -m $dkms_name -v $dkms_version | egrep '(added|built|installed)' > /dev/null); then
    dkms build $dkms_name/$dkms_version
fi

if ! $(dkms status -m $dkms_name -v $dkms_version | egrep '(installed)' > /dev/null); then
    dkms install --force $dkms_name/$dkms_version
fi

exit 0
