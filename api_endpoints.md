
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


##### Orders

Type: **POST**
URL:
```
.../v1/order
```

Returns

```
```

##### Authentication

Register:
> `user#create` - will register a new user and return the email and token in the same format that Log_in does.
Request: `curl -X POST http://localhost:3000/v1/users --data "name=John&email=user@tma.org&password=password&password_confirmation=password"`
Response valid: `{"user":{"email":"user@tma.org"},"authentication_token":{"token":"weREXP7z3TeaRqyznzrt"}}`
Response invalid: `{"message":["Email has already been taken"]}`

Log_in: (generates new token if missing)
>`session#get_token` - will return email and token based on provided credentials (email and password)
Request: `curl -X POST http://localhost:3000/v1/sessions --data "email=user@tma.org&password=password"`
Response valid: `{"user":{"email":"user@tma.org"},"authentication_token":{"token":"zJ894PziZMP3yCdaZSSw"}}`
Response invalid: `{"message":"Email or password is incorrect"}`

Log_out: optional (it is just clearing the stored token)
>`session#clear_token` - will reset the token based on the authorised user (current_user). Can be called on logout with/without waiting for the response.
Request: `curl -X DELETE http://localhost:3000/v1/sessions -H "email: user@tma.org" -H "token: c-LXmsFavPiCEBRvchxe"`
Response valid: `{"message":"Token successfully cleared"}`
Response invalid: `{"message":"Token reset failed"}`

Every authorised request:
>Should have correct headers:
`curl -X GET http://localhost:3000/v1/private_action -H "email: user@tma.org" -H "token: c-LXmsFavPiCEBRvchxe"`
Otherwise Response invalid: `{"message":"Access Forbidden"}`

`authenticate_api_user` method will check that the request has correct headers['email'] and headers['token'] to authorize actions. It is not creating sessions, it is checking the email and token directly from db.
Use on restricted controller actions with:  `before_action :authenticate_api_user, only: [:restricted_action]`
Once authorized, controllers and views have access to instance var: `current_user` (AR object)
If authentication fails, the api will return: `{"message":"Access Forbidden"}`

Postman link: https://www.getpostman.com/collections/8377c2b915864d6eda84
