#!/usr/bin/env bash

set -euo pipefail

# If you want to use a different version of pdf2htmlex, set this variable to
# something else while calling this script. For example:
#
# PDF2HTML_VERSION="0.20.0" ./generate-html-issues.bash

PDF2HTML_VERSION="${PDF2HTML_VERSION:-"0.18.8.rc2-master-20200820-alpine-3.12.0-x86_64"}"

possibly_relative_path_to_repo_root="$(dirname "$0")"
absolute_path_to_repo_root="$(cd "$possibly_relative_path_to_repo_root" ; pwd )"
REPO_ROOT="$absolute_path_to_repo_root"

echo "About to use pdf2htmlex to generate HTML versions of every PDF in '${REPO_ROOT}/docs/issues'..."
echo

for pdf in $(ls "${REPO_ROOT}/docs/issues/"*.pdf)
do
        echo "Checking to see if "${pdf/.pdf/.html}" already exists..."
        if [[ ! -e "${pdf/.pdf/.html}" ]]
        then
                echo "About to convert $pdf..."
                echo
                docker run \
                        -ti \
                        --rm \
                        -v "${REPO_ROOT}/docs/issues":/pdf \
                        -w /pdf \
                        "pdf2htmlex/pdf2htmlex:${PDF2HTML_VERSION}" \
                        --zoom 1.3 \
                        "$(basename "$pdf")"
                echo
                echo "...conversion complete."
                echo
        else
                echo "File $pdf already has a matching ${pdf/.pdf/.html}. Skipping..."
                echo
        fi
done

echo "Done checking all the PDFs"
