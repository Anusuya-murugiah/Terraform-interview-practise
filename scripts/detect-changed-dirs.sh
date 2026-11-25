#!/bin/bash
BASE_REF=${1:-"origin/main"}

CHANGED_FILES=$(git diff --name-only $BASE_REF...HEAD)

# 1. Plan only env folders
CHANGED_DIRS=$(echo "$CHANGED_FILES" | \
  grep -E '^env/.*\.(tf|tfvars)$' | \
  xargs -r -I {} dirname {} | sort -u)

# 2. If a module changed, add every env folder that uses it
MODULE_CHANGES=$(echo "$CHANGED_FILES" | grep '^modules/' | \
  xargs -r -I {} dirname {} | sort -u)

for module_dir in $MODULE_CHANGES; do
  module_name=$(basename "$module_dir")
  DEPENDENT_DIRS=$(grep -rl "source.*modules/$module_name" env/ --include="*.tf" | \
    xargs -r -I {} dirname {} | sort -u)
  CHANGED_DIRS=$(printf "%s\n%s\n" "$CHANGED_DIRS" "$DEPENDENT_DIRS")
done

printf "%s\n" "$CHANGED_DIRS" | sort -u | grep -v '^$'