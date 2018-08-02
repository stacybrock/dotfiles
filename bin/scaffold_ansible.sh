#!/bin/bash

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
