#!/bin/bash
set -euf -o pipefail

echo "activating venv"
. venv/bin/activate

echo "installing pip dependencies"
pip install -q -r requirements.txt

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

echo "everything looks good"