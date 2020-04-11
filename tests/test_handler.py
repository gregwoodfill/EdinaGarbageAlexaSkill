from edina_garbage.handler import lambda_handler


def test_returns_200():
    response = lambda_handler(None, None)
    assert response == {'body': '"Hello from lambda!"', 'status': 200}


def test_break():
    assert False
