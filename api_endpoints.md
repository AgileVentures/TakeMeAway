
### TakeMeAway API

#### Endpoints

##### Menus

Type: **GET**
URL:
```
.../v1/menus
```

Returns

```
{
  "date_range": "2015-05-04..2015-05-10",
  "menus": [
    {
      "id": 2,
      "title": "Monday",
      "start_date": "2015-05-04",
      "end_date": "2015-05-04"
      "uri": "http://localhost:3000/v1/menus/2",
      "item_count": 2,
      "items": [
        {
          "id": 1,
          "item": "Kyckling",
          "price": "20.0",
          "description": "Lorem ipsum"
          "ingredients": "something tasty, ...",
        },
        {
          "id": 2,
          "item": "Biff",
          "price": "15.0",
          "description": "Lorem ipsum..."
          "ingredients": "beef, ...",
        }
      ]
    }
  ]
}
```
##### Session

Type: **POST**
Required keys:
email, password
URL:
```
.../v1/sessions
```

Returns:
On success:
```
{
    "user": {
        "email": "client@tma.org"
    },
    "authentication_token": {
        "token": "iZVUSZi9mNAKntnNsSUf"
    }
}
```
On failure
```
{
    "message": "Error with your login or password"
}
```

##### Orders

Type: **POST**
URL:
```
.../v1/order
```

Returns

```
```
