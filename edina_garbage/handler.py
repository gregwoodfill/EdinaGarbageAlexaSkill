import json


class Moo:
    pass


def lambda_handler(event, context):
    return {
        'status': 200,
        'body': json.dumps('Hello from lambda!')
    }
