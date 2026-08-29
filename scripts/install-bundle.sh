#!/usr/bin/env bash

set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
manifest="$root/bundles.yaml"
codex_home="${CODEX_HOME:-$HOME/.codex}"
installer="${CODEX_SKILL_INSTALLER:-$codex_home/skills/.system/skill-installer/scripts/install-skill-from-github.py}"
destination="$codex_home/skills"
repo="BejeweledMe/codex-pro-agent-skills"
run=false
list=false
replace=false
bundles=()

usage() {
  printf '%s\n' "Usage: $0 --bundle NAME [--bundle NAME ...] [--run] [--replace]"
  printf '%s\n' "       $0 --list"
  printf '%s\n' "Prints the official GitHub installer command by default. --run executes it."
  printf '%s\n' "--replace backs up existing skill directories before installing updates."
}

while (($#)); do
  case "$1" in
    --bundle)
      (($# >= 2)) || { usage >&2; exit 2; }
      bundles+=("$2")
      shift 2
      ;;
    --list)
      list=true
      shift
      ;;
    --run)
      run=true
      shift
      ;;
    --replace)
      replace=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown argument: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if "$list"; then
  ruby -ryaml -e 'm = YAML.load_file(ARGV[0]); m.fetch("bundles").each { |n, b| puts "#{n}\t#{b.fetch("description")}" }' "$manifest"
  exit 0
fi

((${#bundles[@]})) || { usage >&2; exit 2; }
[[ -f "$installer" ]] || { printf 'Official Codex skill installer not found: %s\n' "$installer" >&2; exit 1; }

skills=()
while IFS= read -r skill; do
  skills+=("$skill")
done < <(ruby -ryaml -e '
  m = YAML.load_file(ARGV.shift)
  selected = ARGV
  available = m.fetch("bundles")
  selected.each { |n| abort "Unknown bundle: #{n}" unless available.key?(n) }
  seen = {}
  selected.each do |n|
    available.fetch(n).fetch("skills").each do |s|
      next if seen[s]
      seen[s] = true
      puts s
    end
  end
' "$manifest" "${bundles[@]}")

command=(python3 "$installer" --method git --repo "$repo" --path)
for skill in "${skills[@]}"; do
  command+=("skills/$skill")
done

printf '%q ' "${command[@]}"
printf '\n'

if "$run"; then
  conflicts=()
  for skill in "${skills[@]}"; do
    [[ -e "$destination/$skill" ]] && conflicts+=("$skill")
  done

  if ((${#conflicts[@]})); then
    if ! "$replace"; then
      printf 'Existing skills will not be overwritten: %s\n' "${conflicts[*]}" >&2
      printf 'Re-run with --run --replace to back up and replace only these skills.\n' >&2
      exit 1
    fi

    staging="$(mktemp -d "$destination/.bundle-staging.XXXXXX")"
    staging_command=(python3 "$installer" --method git --repo "$repo" --dest "$staging" --path)
    for skill in "${skills[@]}"; do
      staging_command+=("skills/$skill")
    done

    if ! "${staging_command[@]}"; then
      if rmdir "$staging" 2>/dev/null; then
        printf 'Update download failed; existing skills were left unchanged. Empty staging was removed.\n' >&2
      else
        printf 'Update download failed; existing skills were left unchanged. Partial staging: %s\n' "$staging" >&2
      fi
      exit 1
    fi

    backup="$destination/.bundle-backups/$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup"
    for skill in "${conflicts[@]}"; do
      mv "$destination/$skill" "$backup/$skill"
    done
    for skill in "${skills[@]}"; do
      mv "$staging/$skill" "$destination/$skill"
    done
    rmdir "$staging"
    printf 'Backed up existing skills to %s\n' "$backup" >&2
    exit 0
  fi

  exec "${command[@]}"
fi
