
# Jenkins_on_ec2

A jenkins server hosted on amazon ec2 



## Tech Stack

**Infrastructure As Code:** Terraform

**Configuring Tool:** Ansible

**Cloud:** AWS

**Container runtime**: Docker


## Run Locally

Clone the project

```bash
  git clone https://link-to-project
```

Go to the project directory

```bash
  cd my-project
```
configure aws cli


```bash
 # Change my_ip value to your ip address in secrets.tfvar
  cd terraform
  terraform init 
  terraform apply -var-file="secrets.tfvar"
```



```bash
  cd ansible
 # change the inventory with ec2 ip address
  ansible -i inventory playbook.yaml
```

