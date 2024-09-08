#!/usr/bin/env bash

wkhtmltopdf  --page-width 2048 --images --enable-local-file-access \
  http://localhost:4567/x x.pdf

find . -name "*.pdf" -exec pdfinfo "{}" ";" | ag Pages
