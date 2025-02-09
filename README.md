# Ansible installation
<p>Inside this directory, you will create the necessary files:</p><ul><li>
  <code>Dockerfile</code> (for building the Ansible container)</li><li>
  <code>docker-compose.yml</code> (for managing the container)</li><li>
  <code>ansible.cfg</code> (optional, for configuration)</li><li>
  <code>playbooks/</code> (directory to store Ansible playbooks)</li></ul>


### Build and Run the Container
Run the following command to build the Ansible container:
```bash
docker-compose build
```
To start an interactive Ansible container:
```bash
docker-compose run ansible bash || docker-compose up -d 
```
Now you can run the playbook inside the container:
```bash
ansible-playbook /ansible/playbooks/test-playbook.yml
```
