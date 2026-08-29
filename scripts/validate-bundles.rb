#!/usr/bin/env ruby

require "yaml"
require "set"

root = File.expand_path("..", __dir__)
manifest_path = File.join(root, "bundles.yaml")
manifest = YAML.load_file(manifest_path)
bundles = manifest.fetch("bundles")
actual = Dir.children(File.join(root, "skills")).select do |name|
  File.file?(File.join(root, "skills", name, "SKILL.md"))
end.to_set
errors = []

bundles.each do |name, spec|
  skills = spec["skills"]
  unless skills.is_a?(Array) && !skills.empty?
    errors << "bundle #{name} must contain a non-empty skills list"
    next
  end
  duplicates = skills.group_by(&:itself).select { |_, values| values.length > 1 }.keys
  errors << "bundle #{name} has duplicate skills: #{duplicates.join(", ")}" unless duplicates.empty?
  missing = skills.to_set - actual
  errors << "bundle #{name} references missing skills: #{missing.to_a.sort.join(", ")}" unless missing.empty?
end

all = bundles.fetch("all").fetch("skills").to_set
errors << "bundle all is missing: #{(actual - all).to_a.sort.join(", ")}" unless (actual - all).empty?
errors << "bundle all has unknown skills: #{(all - actual).to_a.sort.join(", ")}" unless (all - actual).empty?

covered = bundles.reject { |name, _| name == "all" }.values.flat_map { |spec| spec.fetch("skills") }.to_set
errors << "skills not covered by a named bundle: #{(actual - covered).to_a.sort.join(", ")}" unless (actual - covered).empty?

if errors.empty?
  puts "bundles valid: #{bundles.length} bundles, #{actual.length} skills"
else
  warn errors.join("\n")
  exit 1
end
