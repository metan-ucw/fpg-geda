#!/bin/sh

echo "Symbols" > README.md
echo "=======" >> README.md
echo >> README.md

for i in *; do
	if ! [ -d "$i" ]; then
		continue
	fi

	echo $i >> README.md
	echo $(echo $i | sed s/./-/g) >> README.md
	echo >> README.md

	for png in $(ls -v "$i/"*.png); do
		title=$(basename "$png" .png)
		echo "![$title]($png?raw=true \"$title\")" >> README.md
	done

	echo >> README.md
done
