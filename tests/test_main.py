import pytest
from app.main import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_get_books(client):
    response = client.get('/books')
    assert response.status_code == 200
    assert response.is_json
    data = response.get_json()
    assert isinstance(data, dict)

def test_get_book_by_id(client):
    response = client.get('/books/1')
    assert response.status_code == 200
    assert response.is_json
    data = response.get_json()
    assert 'title' in data
    assert 'author' in data
    assert 'year' in data

def test_get_book_not_found(client):
    response = client.get('/books/999')
    assert response.status_code == 404
