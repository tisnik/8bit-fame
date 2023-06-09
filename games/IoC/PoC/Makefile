type-checks:
	MYPYPATH=game: mypy --explicit-package-bases game

strict-type-checks:
	MYPYPATH=game: mypy --strict --explicit-package-bases game

missing-types:
	MYPYPATH=game: mypy --explicit-package-bases --disallow-untyped-calls --disallow-untyped-defs --disallow-incomplete-defs game
