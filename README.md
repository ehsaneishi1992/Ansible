# Ansible installation
<p>Inside this directory, you will create the necessary files:</p><ul><li>
  <code>Dockerfile</code> (for building the Ansible container)</li><li>
  <code>docker-compose.yml</code> (for managing the container)</li><li>
  <code>ansible.cfg</code> (optional, for configuration)</li><li>
  <code>playbooks/</code> (directory to store Ansible playbooks)</li></ul>

```graphsq
ansible/
├── inventory/
│   ├── production.ini
│   ├── group_vars/
│   │   ├── db_servers.yml  # Store MySQL passwords here
├── playbooks/
│   ├── install_mysql_client.yml
│   ├── create_directory.yml
│   ├── run_mysql_query.yml  # The playbook for executing MySQL queries
```

### Build and Run the Container
Run the following command to build the Ansible container:
```bash
docker-compose build
```
To start an interactive Ansible container:
```bash
docker-compose run ansible bash || docker-compose up -d 
```

### Configure Passwordless Sudo (If Allowed)
If your servers allow it, configure passwordless sudo for Ansible:
Log in to each server and edit the sudoers file:
```bash
visudo
```
Add this line at the end:
```sql
SERVER_USERNAME ALL=(ALL) NOPASSWD: ALL
```
and then modify favaadmin's sudo permissions:
```bash
sudo usermod -aG sudo SERVER_USERNAME
```
Now, Ansible won't ask for a <code>sudo</code> password when running <code>become: yes</code>.

### 1. Use SSH Key Authentication (Best Practice)
For secure and efficient management of multiple servers, SSH key authentication is the preferred method.
Step 1: Generate an SSH Key Pair (If You Don't Have One)
If you haven't already created an SSH key pair for Ansible, you can generate it with:
```bash
ssh-keygen -t rsa -b 2048 -f ~/.ssh/ansible_id_rsa
```
Step 2: Copy the Public Key to All Servers
You need to copy the public key (~/.ssh/ansible_id_rsa.pub) to all 80 servers. You can do this manually or use the ssh-copy-id command for each server:
```bash
ssh-copy-id -i ~/.ssh/ansible_id_rsa.pub SERVER_USERNAME@IP_SERVER
```
Repeat this step for all servers. If the number of servers is large, you can automate this with a script.

### 2. Use an Encrypted Vault if use username and password to login to server (Best Practice for Security)
Instead of storing the password in plain text, use Ansible Vault to encrypt it.
Create an encrypted vault fil 
```bash
EDITOR=nano ansible-vault create /ansible/playbooks/vault.yml
```
```bash
EDITOR=nano ansible-vault edit /ansible/playbooks/vault.yml
```

### Now you can run the playbook inside the container:
```bash
ansible-playbook -i /ansible/playbooks/inventory/production.ini /ansible/playbooks/create_directory.yml 
```
```bash
ansible-playbook -i /ansible/playbooks/inventory/production.ini /ansible/playbooks/create_directory.yml --ask-vault-pass
```

