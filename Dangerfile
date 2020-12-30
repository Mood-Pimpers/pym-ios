# Run SwiftLint
swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_files inline_mode: true

# Enforce clean Git history
if git.commits.any? { |c| c.message =~ /^Merge branch/ }
  fail('Please rebase to get rid of the merge commits in this PR')
end

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

# Generate test coverage
slather.configure("Pym.xcodeproj", "Pym", options: {
  ignore_list: [
	"**/*.generated.swift"
  ]
})

slather.notify_if_coverage_is_less_than(minimum_coverage: 80)
slather.notify_if_modified_file_is_less_than(minimum_coverage: 60)
slather.show_coverage