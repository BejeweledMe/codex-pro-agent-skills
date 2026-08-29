#!/usr/bin/env bash

set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
manifest="$root/bundles.yaml"
installer="${CODEX_HOME:-$HOME/.codex}/skills/.system/skill-installer/scripts/install-skill-from-github.py"
repo="BejeweledMe/codex-pro-agent-skills"
run=false
list=false
bundles=()

usage() {
  printf '%s\n' "Usage: $0 --bundle NAME [--bundle NAME ...] [--run]"
  printf '%s\n' "       $0 --list"
  printf '%s\n' "Prints the official GitHub installer command by default. --run executes it."
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
  exec "${command[@]}"
fi
