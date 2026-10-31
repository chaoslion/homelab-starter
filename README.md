# Homelab On Debian

> Homelab Controller Setup

## Root Setup

```bash
apt update
apt install curl fzf git git-lfs jq just sudo
adduser --disabled-password --gecos "" homelab
usermod -aG sudo homelab
echo "%sudo ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/99-homelab
echo "PermitRootLogin yes" > /etc/ssh/sshd_config.d/99-homelab.conf
systemctl restart sshd
```

## User Setup

> Clone Repo

```bash
# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
cd ~/homelab-starter
# create certificate authority into homelab-starter/homelab
ssh-keygen -t ed25519 -f homelab/ca -C 'homelab ca'
uv sync
uv run ansible-galaxy collection install --upgrade -r requirements.yaml
# install client cert
uv run ansible-playbook homelab.nodes.sshcert_client
# install server cert
uv run ansible-playbook homelab.nodes.sshcert_server --extra-vars "sshcert_server_hostname=homelab-dev"
sudo systemctl restart sshd
```
