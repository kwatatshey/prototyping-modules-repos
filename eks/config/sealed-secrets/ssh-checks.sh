#!/bin/bash

# Store the content of the SSH private key from the Kubernetes secret in a variable
secret_ssh_private_key=$(kubectl get secret argoproj-ssh-creds -n argocd -o jsonpath='{.data.sshPrivateKey}' | base64 --decode)

# Store the content of the SSH private key from the sealed-ssh-secret.yaml file in a variable
yaml_ssh_private_key=$(awk '/sshPrivateKey: \|/{flag=1;next}/^$/{flag=0}flag' sealed-ssh-secret.yaml | awk '{$1=$1;print}')

# Print the SSH private keys and their lengths
echo "Secret SSH private key:"
echo "$secret_ssh_private_key"
echo "Length: ${#secret_ssh_private_key}"
echo
echo "YAML SSH private key:"
echo "$yaml_ssh_private_key"
echo "Length: ${#yaml_ssh_private_key}"

# Compare the SSH private keys
if [ "$secret_ssh_private_key" == "$yaml_ssh_private_key" ]; then
    echo "SSH private keys match!"
else
    echo "SSH private keys do not match!"
fi
