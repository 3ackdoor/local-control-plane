#!/bin/bash

. $(pwd)/../base/env-vars.sh

gcloud compute scp $pwd/util/construct-crossplane.sh $VM_NAME:./