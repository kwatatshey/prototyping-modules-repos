https://levelup.gitconnected.com/orchestrating-cloud-resources-with-argocd-and-terraform-0e8a16ee24c7


#To print the ssh private key localy
```
openssl base64 -in ~/.ssh/github_private | tr -d '\n'
```

To check the real value of the ssh_private_key in Kubernetes, you can use the kubectl command to get the secret and decode the base64 encoded value. Here's how you can do it:

First, get the secret in JSON format:

```
kubectl get secret argoproj-ssh-creds -n argocd -o json
```

This command will output the secret named argoproj-ssh-creds in the argocd namespace in JSON format.

From the output, find the sshPrivateKey field under data. The value of this field is the base64 encoded SSH private key.

Decode the base64 encoded SSH private key:

```
echo 'base64_encoded_ssh_private_key' | base64 —decode
```

Replace base64_encoded_ssh_private_key with the actual base64 encoded SSH private key you got from step 2. This command will output the decoded SSH private key.

Please note that you need to have the necessary permissions to get secrets in the argocd namespace. Also, the base64 command might be different depending on your operating system. The above command works on Unix-like systems. If you're using Windows, you might need to use a different command to decode the base64 encoded SSH private key.


To directly view the value of the sshPrivateKey field in the Kubernetes secret, you can use the kubectl get secret command with the -o jsonpath option to extract the specific field. Here's how you can do it:

```
kubectl get secret argoproj-ssh-creds -n argocd -o jsonpath='{.data.sshPrivateKey}' | base64 --decode
```


Make sure you pub key is added to github account and private
This is how it appears in github

pub-argocd-ssh-creds
SHA256:2cgblhZ/GMD9L+rbeWq3BtfNDtmDTKGZGngerf3TU5E

and in local

➜  ~ cd .ssh
➜  .ssh ls
config                  gitlab_private.pub      {bitbucket_private}
github_private          id_rsa                  {bitbucket_private}.pub
github_private.pub      id_rsa.pub              {bitbucket}
gitlab                  known_hosts             {bitbucket}.pub
gitlab.pub              known_hosts.bak
gitlab_private          known_hosts.old
➜  .ssh cat github_private.pub
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILNsEQsnS+Xsvuj8MMyG9vbq25aghabCyDMMFImvOGXY gauthier.kwatatshey@gmail.com
➜  .ssh

github_private  = This is a private key
github_private.pub = This is a public key to be added in github account