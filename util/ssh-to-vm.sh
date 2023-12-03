#!/bin/bash

. $(pwd)/../base/env-vars.sh

# SSH to VM
gcloud compute ssh $VM_NAME
