#!/bin/bash
set -euf -o pipefail

echo "check if poetry exists"
poetry -V

echo "activating venv"
poetry shell

echo "installing pip dependencies"
poetry install

echo "autoformat main"
autopep8 -i -r edina_garbage

echo "autoformat test"
autopep8 -i -r tests

echo "linting main"
flake8 edina_garbage

echo "linting tests"
flake8 tests

echo "running tests"
pytest

echo "packaging"
bin/package

echo "Ready to go!"
