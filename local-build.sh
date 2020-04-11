#!/bin/bash
set -euf -o pipefail

echo "check if poetry exists"
poetry -V

echo "installing pip dependencies"
poetry install

echo "autoformat main"
poetry run autopep8 -i -r edina_garbage

echo "autoformat test"
poetry run autopep8 -i -r tests

echo "linting main"
poetry run flake8 edina_garbage

echo "linting tests"
poetry run flake8 tests

echo "running tests"
poetry run pytest

echo "packaging"
bin/package

echo "format and validate tf"
pushd infrastructure
    terraform fmt
    terraform validate
popd

echo "Ready to go!"
