init:
	git update-index --skip-worktree Pym/PymCore/Sources/Generated/UIKitAssets.generated.swift
	git update-index --skip-worktree Pym/PymCore/Sources/Generated/Assets.generated.swift
	git update-index --skip-worktree Pym/PymCore/Sources/Generated/Strings.generated.swift
	git update-index --skip-worktree Pym/PymCore/Sources/Generated/CoreData.generated.swift
	mint bootstrap