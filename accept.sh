#!/bin/bash

set -e

cd fixtures

../doc-to-md.sh public.docx public_files > public.md
