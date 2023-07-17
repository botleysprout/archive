#!/bin/bash

input_pdf="${1:?"Please specify an input pdf: $0 /some/file.pdf"}"

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default \
    -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages \
    -dCompressFonts=true -r150 -sOutputFile="${input_pdf/.pdf/-compressed.pdf}" "${input_pdf}"
