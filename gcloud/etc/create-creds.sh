#!/bin/bash

. $(pwd)/../base/env-vars.sh

gcloud compute scp $pwd/creds.json $VM_NAME:./