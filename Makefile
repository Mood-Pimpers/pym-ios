init:
	git update-index --skip-worktree Pym/PymCore/Sources/Generated/Assets+Generated.swift
	git update-index --skip-worktree Pym/PymCore/Sources/Generated/Strings+Generated.swift
	git update-index --skip-worktree Pym/PymCore/Sources/Generated/CoreData+Generated.swift
	mint bootstrap