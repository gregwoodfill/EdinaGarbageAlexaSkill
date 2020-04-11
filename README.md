# Alexa Skill to Get Garbage Schedule for Edina

![branch build](https://github.com/gregwoodfill/EdinaGarbageAlexaSkill/workflows/branch%20build/badge.svg)

## Set Up

intall pyenv

```
brew install pyenv
pyenv install 3.8.2
```

set up virtual environment
`virtualenv venv`

install [poetry](https://github.com/python-poetry/poetry)

```bash
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
```

## Building

run local build

```
./local-build.sh
```

Run terraform

```
terraform init
terraform plan
terraform apply
```
