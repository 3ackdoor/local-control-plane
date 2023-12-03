# Note

## Steps on Workstation VM (Automatically Setup Crossplane)

- Run `cd gcloud` to change current directory path
- Run `./setup-crossplane.sh` to automatically run all setup steps

## Steps on Workstation VM (Manual Setup Crossplane)

- Run `cd gcloud` to change current directory path
- Run `minikube start` to start minikube
- Run `minikube addons enable ingress` to install ingress
- Run `minikube addons enable ingress-dns` to install ingress-dns
  - Wait until you see the ingress-nginx-controller-XXXX is up and running using `kubectl get pods -n ingress-nginx`
- Run `./util/install-crossplane.sh` to install crossplane
- Run `./util/install-provider-gcp.sh` to install GCP provider
- Run `[[ -z "$GOOGLE_APPLICATION_CREDENTIALS" ]] && sudo echo 'export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.config/gcloud/application_default_credentials.json' | tee -a ~/.bashrc` to set env variable with the google credentials path
- Run `source ~/.bashrc` to refresh current shell env
- Create a Secret from current login creds (`GOOGLE_APPLICATION_CREDENTIALS`) or `GCP_CREDS_LOCAL_CONTROL_PLANE`
  - Run `kubectl create secret generic gcp-secret -n crossplane-system --from-file=creds=$GOOGLE_APPLICATION_CREDENTIALS` to set k8s secret
    - Run `kubectl get secret gcp-secret -n crossplane-system --template={{.data.creds}} | base64 --decode` to check the result
- Run the following command

```bash
cat <<EOF | kubectl apply -f -
apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  projectID: $GCP_PROJECT
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: gcp-secret
      key: creds
EOF
```

### Notes

```text
# Default path to find credentials file is: [/home/user/.config/gcloud/application_default_credentials.json]
```

### Useful commands & ETC

```text
# kubectl cluster-info --context kind-kind

# <!-- Run the following command every time after the VM workstation has started -->
gcloud workstations configs update local-control-plane-ws-config --project=gitops-learning01 --cluster=local-control-plane-ws-cluster --region=asia-southeast1 --container-command="eval \$(ssh-agent) && gcloud secrets versions access 1 --secret=SSH_PRIVATE_KEY_LOCAL_CONTROL_PLANE --project=gitops-learning01 --format='get(payload.data)' | tr '_-' '/+' | base64 -d | ssh-add - >/dev/null"
```

### References

<https://gist.github.com/vfarcic/fca66711eaf0440483eba42ee013311a>
