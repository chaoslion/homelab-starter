mod homelab "~/.ansible/collections/ansible_collections/homelab/nodes/playbooks/files/just/homelab.just"

[default]
_default:
    just --choose

bump-monitor:
    ansible-playbook homelab.nodes.projects_provision -tbump -l*monitor__prometheus
