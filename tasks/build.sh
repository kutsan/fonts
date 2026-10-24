set -o errexit -o nounset -o pipefail
shopt -s nullglob

readonly AGE_RECIPIENT='age1pfzafy7se2ta94tmhnu4n8kshdd7j7722sfzecd9s43xagpte4vscj5944'
readonly SOURCE_DIRECTORY="$MISE_PROJECT_ROOT/src"
readonly DISTRIBUTION_DIRECTORY="$MISE_PROJECT_ROOT/dist"
readonly ENCRYPTED_ARCHIVE_PATH="$DISTRIBUTION_DIRECTORY/fonts.tar.gz.age"

mkdir -p -- "$DISTRIBUTION_DIRECTORY"
cd -- "$SOURCE_DIRECTORY"
font_files=(*.ttf)
readonly font_files

((${#font_files[@]} > 0)) || {
	printf 'No .ttf files found in %s\n' "$SOURCE_DIRECTORY" >&2
	exit 1
}

tar --create --gzip --file - -- "${font_files[@]}" |
	age --recipient "$AGE_RECIPIENT" --output "$ENCRYPTED_ARCHIVE_PATH"

printf 'Encrypted %s fonts into %s\n' "${#font_files[@]}" "$ENCRYPTED_ARCHIVE_PATH"
