## Prereqs on your machine
- Terraform v0.12.x
- Ansible

## Usage

Set terraform.tfvars

Then to start it up, run the following:

```console
> terraform init
> terraform apply
```

Wait for the installation to complete, and hurah! you now have a 3-instance ece installation ready on AWS!

You'll be presented with the URL to log in to ece.
The admin password will be presented above as part of the running ansible flow like this:
```
null_resource.run-ansible (local-exec): ok: [some-instance-public-dns-address] => {
null_resource.run-ansible (local-exec):     "msg": "Adminconsole password is: <PASSWORD> "
null_resource.run-ansible (local-exec): }
```

To tear it down run:

```console
> terraform destroy
```
