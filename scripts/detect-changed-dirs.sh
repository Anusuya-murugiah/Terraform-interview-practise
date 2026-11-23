#!/bin/bash
# scripts/detect-changed-dirs.sh
# Find all Terraform directories that have changes

BASE_REF=${1:-"origin/main"}

# Get list of changed files
CHANGED_FILES=$(git diff --name-only $BASE_REF...HEAD)

# Find unique Terraform directories that contain changes
CHANGED_DIRS=$(echo "$CHANGED_FILES" | \
  grep -E '\.(tf|tfvars)$' | \
  xargs -I {} dirname {} | \
  sort -u)

# Also detect changes in shared modules
MODULE_CHANGES=$(echo "$CHANGED_FILES" | grep "^modules/" | \
  xargs -I {} dirname {} | sort -u)

# If a module changed, find all directories that reference it
if [ -n "$MODULE_CHANGES" ]; then
  for module_dir in $MODULE_CHANGES; do
    module_name=$(basename $module_dir)
    # Find all directories that use this module
    DEPENDENT_DIRS=$(grep -rl "source.*modules/$module_name" environments/ --include="*.tf" | \
      xargs -I {} dirname {} | sort -u)
    CHANGED_DIRS=$(printf "%s\n%s\n" "$CHANGED_DIRS" "$DEPENDENT_DIRS")
  done
fi

# Output unique directories
printf "%s\n" "$CHANGED_DIRS" | sort -u | grep -v '^$'
