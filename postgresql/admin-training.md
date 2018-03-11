# PostgreSQL Administration Training - March 8, 2018

[Slides](http://slides.keithf4.com/pg_admin_training_centos/)

---

```bash
$ psql --verson
```

Cluster vs. Database?

* cluster is the entire instance
* our setup initializes a cluster
* within the cluster, we can make multiple databases

After you install Postgres:

* no clusters are automaticalyl created
* no initial automatic setup either

```
sudo /usr/pgsql-10/bin/postgresql-10-setup initdb
sudo systemctl enable postgresql-10
sudo systemctl start postgresql-10
```

* you can see command history by typing `\s`

Creating passwords for "roles" or "users"

* lets say we the roles `training` and `replication`
* to set passwords we would type:

```bash
\password training
\password replication
```

* to start postgres with a certain role, you would do: `psql -d training`

---

We go into `pg_hba.conf` and so some config for auth

Also - a lot of the config when setting up a Postgres system can be found in `postgresql.conf`


