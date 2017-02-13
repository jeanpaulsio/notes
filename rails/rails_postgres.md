# Setting up PostgresQL on Mac OSX

* Install postgres:

```
$ brew install postgres
```

* Initialize Postgres

```
$ initdb /usr/local/var/postgres
```

* Set up Postgres to run at startup
* Create directory `~/Library/LaunchAgents` if it doesn't exist
* Find plist that comes with postgres install. I.e: `/usr/local/Cellar/postgresql/9.3.4/homebrew.mxcl.postgresql.plist`
* Copy plist file to `LaunchAgents` directory

```
$ cp /usr/local/Cellar/postgresql/9.3.4/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
```

* Use launchctl to load the file using this command:

```
$ launchctl load -w homebrew.mxcl.postgresql.plist
```

## 1. Create a new rails project

```
$ rails new img-upload --database=postgresql
```

## 2. CD into the project

```
$ cd img-upload
```

## 3. Create the Postgres User

```
$ createuser img-upload
```

## 4. Create the database

```
$ createdb -Oimg-upload -Eutf8 img-upload_development
$ createdb -Oimg-upload -Eutf8 img-upload_test
```
