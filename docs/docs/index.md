# Houses Service

For full Bark documentation visit [http://localhost/docs](http://localhost/docs).

## Create House

POST `/houses`

*POST parameters*

Name         | Validation
------------ | -------------
address      | optional 
title        | required

*Response [200]*

```json
{
  "id": 1,
  "user_id": 1,
  "title": "MyHouse",
  "address": "Baker Street 221B",
  "key": "2d931510-d99f-494a-8c67-87feb05e1594",
  "secret": "cd8a74e54129e64172fe692526dfb4c9641639e95ac48e91c0d3be2c03a32e5c",
  "created_at": "2017-11-11 11:04:44 UTC",
  "updated_at": "2017-1-11 11:04:44 UTC"
}
```

*Error Response [422]*

```json
[
  ["title", ["must be filled"]]
]
```

*Error Response [401]*

Wrong user token

## Update User

POST `/users/update`

*Authorization*

To update user you need to send his token via `HTTP_AUTHORIZATION` header. Example:
`Authorization: Bearer <token>`.

*POST parameters*

Name         | Validation
------------ | -------------
username     | optional 
password     | optional

*Response [200]*

```json
{
  "id": 1,
  "username": "Bob",
  "email": "bob@test.com",
  "token": "2d931510-d99f-494a-8c67-87feb05e1594",
  "created_at": "2017-11-11 11:04:44 UTC",
  "updated_at": "2017-1-11 11:04:44 UTC"
}
```

*Error Response [401]*

No token provided

*Error Response [404]*

Usr not found via provided token
