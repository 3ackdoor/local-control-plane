#!/bin/bash

. $(pwd)/../base/env-vars.sh

# Add startup-script to GCE instance
gcloud compute instances add-metadata $VM_NAME --metadata-from-file=startup-script=$(pwd)/util/setup-vm.sh