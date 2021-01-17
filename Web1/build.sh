#!/bin/sh

/usr/bin/pandoc web1.md -o web1.pdf --from markdown --template eisvogel.latex --listings --pdf-engine=xelatex
