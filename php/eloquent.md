# Basic Usage

__Defining a Model__

To get started, you need to have an Eloquent Model

Models are typically found in an `app` directory

All Eloquent models extend `Illuminate\Database\Eloquent\Model`

```php
<?php
class User extends \Illuminate\Database\Eloquent\Model {
}
```

Eloquent will assume that we have a table called `users` as it takes the lowercase snake name of our model

Eloquent assumes that each table has a primary key column named `id`.

Our tables also need to have an `updated_at` and `created_at` fields.


__Retrieving All Records__

```php
$users = User::all();
```

__Retriefing Record by Primary Key__

```php
$user = User::find(1);

var_dump($user->name);
```


