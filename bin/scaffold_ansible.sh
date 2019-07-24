#!/usr/bin/env bash

if [[ $1 = '' || $1 = '-h' || $1 = '--help' ]]; then
    cat << EOF
Usage: scaffold_ansible.sh [-h] ROLES

Scaffolds an ansible playbook directory structure inside the current directory.

  -h, --help  Show usage
  ROLES       Role name, or comma-separated list of role names to create
EOF
    exit 0
fi

echo "Creating directory structure..."
mkdir group_vars
mkdir inventory

echo "Setting up group_vars/ and inventory/..."
for ANSIBLE_DIR in 'group_vars' 'inventory'; do
cat > $ANSIBLE_DIR/.gitignore << EOF
# ignore the files in this directory
*
# ...except this one
!.gitignore
EOF
done

echo "Setting up roles..."
for ROLE in "$@"; do
    echo "  Scaffolding '$ROLE'..."
    mkdir -p roles/$ROLE/tasks
    mkdir roles/$ROLE/files
    mkdir roles/$ROLE/templates
    touch roles/$ROLE/tasks/main.yml

    echo "  Generating $ROLE.yml..."
    cat > $ROLE.yml << EOF
---
- hosts: all
  gather_facts: yes
  remote_user: root
  roles:
    - $ROLE
EOF
done

touch README.md

echo "Done."
