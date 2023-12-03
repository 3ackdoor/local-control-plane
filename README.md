# Local Control Plane

This project use `cluster per environment` approach \
Ref: <https://learnk8s.io/how-many-clusters>

## Prerequisites

- `gcloud` CLI
- A Google Cloud project
- `envsubst` tool installed on your local machine
- GCP Billing Account

## Steps on your local machine (execute scripts manually)

- Replace any values inside `../base/env-vars.sh` with an appropriated value the match your preference
- Run `cd gcloud` to change current directory path
- Run `./local/create-project.sh` to create a project
- Run `./local/link-billing-account.sh` to link the billing account
- Run `./local/set-gcloud-config.sh` to set gcloud configuration on local machine
- Run `./local/create-service-account.sh` to create a service account
- Run `./local/download-service-account.sh` to download a service account json file
- Run `./local/create-temp-network.sh` to create a network
- Run `./local/create-temp-firewall.sh` to create a firewall
- Run `./local/create-cloud-workstation.sh` to create a cloud workstation

## Steps on your local machine (execute the entire scripts in a single command)

- Run `cd gcloud` to change current directory path
- Run `./local/run.sh` to create a project

## Steps on Workstation VM (only for first time)

- Execute `gcloud auth application-default login --no-launch-browser` command to login with application-default
- Execute `gcloud auth login` command to login again
- Execute `gcloud config set project gitops-learning01` to set config project id
- Execute `sudo apt update && sudo apt install openssh-client` command to install ssh client
- Execute `eval $(ssh-agent)` command to start ssh-agent
- Copy the ssh private key from the existing ssh-key which is binding on Bitbucket/GitLab/Github...
  - Execute this command on your local machine `cat id_ed25519 | pbcopy`
- Create a ssh-key secret using ***Google Cloud console UI*** using the previous step as value (paste on `Secret value` field) with a secret key name `SSH_PRIVATE_KEY_LOCAL_CONTROL_PLANE`
- Create a gcp-creds secret using ***Google Cloud console UI*** with a secret key name `GCP_CREDS_LOCAL_CONTROL_PLANE` and `creds.json` that you just downloaded on your local machine from `./local/download-service-account.sh` script
- Run `gcloud secrets versions access 1 --secret="SSH_PRIVATE_KEY_LOCAL_CONTROL_PLANE" --project=gitops-learning01 | ssh-add - >/dev/null` to add ssh-key from Secret Manager
- Run `git clone git@github.com:3ackdoor/local-control-plane.git` to clone the repo # change my account (3ackdoor) to your git username
- Open `local-control-plane` project from left sidebar of CodeOSS

## Steps to repeat every startup of Workstation VM (script)

- Run `cd gcloud` to change current directory path
- Run `source ./workstation/on-startup.sh` to automatically run all setup steps

## Steps to repeat every startup of Workstation VM (manual)

- Run `cd gcloud`
- Run `eval $(ssh-agent)`
- Run `gcloud secrets versions access 1 --secret="SSH_PRIVATE_KEY_LOCAL_CONTROL_PLANE" --project=gitops-learning01 | ssh-add - >/dev/null`
- Run `gcloud secrets versions access 1 --secret="GCP_CREDS_LOCAL_CONTROL_PLANE" --project=gitops-learning01 --out-file=/home/user/.config/gcloud/root-ca.json >/dev/null`
- Run `git config --global user.email "your_git@email.com"`
- Run `git config --global user.name "Your Name"`
- Run `minikube start`
- Run `./workstation/pull-gke-kubeconfig.sh` or run the following commands manually
  - Run `gcloud auth activate-service-account root-ca@gitops-learning01.iam.gserviceaccount.com --key-file=/home/user/.config/gcloud/root-ca.json`
  - Run `yes | gcloud config set project gitops-learning01`
  - Run `gcloud container clusters get-credentials gl-alpha-private-controller-cluster-0 --zone asia-southeast1-b --project gitops-learning01`
- Run `gcloud container clusters update gl-alpha-private-controller-cluster-0 --zone asia-southeast1-b --enable-master-authorized-networks --master-authorized-networks $(gcloud compute instances describe "$(gcloud compute instances list | grep local-control-plane-ws-config | awk '{print $1}')" --format='get(networkInterfaces[0].accessConfigs[0].natIP)')/32`

## Setup GKE Cluster

- Run `cd gcloud` to change current directory path
- Run `./workstation/create-gke-cluster.sh` to create GKE Cluster then wait for provisioning process
- Run `./workstation/create-firewall-rules-for-nginx-ingress.sh` to create a firewall rule for nginx-ingress
- Run `./workstation/create-reverse-external-static-ip-address.sh` to create a reverse external static ip address for nginx-ingress

### Next Step

- Run `cd ~` to change current directory path
- Run `git clone git@github.com:3ackdoor/infra-services-apps.git` to clone infra-services-apps and follow the instruction in README.md file # change my account (3ackdoor) to your git username

## Delete Only GKE Cluster

- Run `cd gcloud` to change current directory path
- Run `./util/delete-gke-cluster.sh` to delete GKE Cluster

## Cleanup GCP Project

- Run `cd gcloud` to change current directory path
- Run `./util/cleanup-project.sh` to cleanup the current GCP project

## Delete GCP Project

- Run `cd gcloud` to change current directory path
- Run `./util/delete-project.sh` to delete the current GCP project
