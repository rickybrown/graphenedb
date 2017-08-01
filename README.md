# GrapheneDB
Simple Ruby Wrapper for the GrapheneDB API


## Requirements

 * Ruby >= 2.0.0
 * [GrapheneDB account](https://app.graphenedb.com/signup)
 * [GrapheneDB API Key](https://app.graphenedb.com/account/api-clients)


## Install

Use 'gem install' command or add graphenedb to Gemfile
```shell
gem install graphenedb
```

## Configure

If you don't have a GrapheneDB account, sign up [here](https://app.graphenedb.com/signup),
then get your api key [here](https://app.graphenedb.com/account/api-clients).

```ruby
Graphenedb.configure do |config|
  config.api_key = 'your-api-key'
  # configuration defaults, uncomment to change
  # config.version = 'v314'
  # config.region  = 'us-east-1'
  # config.plan    = 'sandbox'
end
```


## Usage

To list available database versions:

```ruby
Graphenedb.versions
```

To get the status of an async operation:

```ruby
Graphenedb.operation('operation-id')
```

---

To list all databases:

```ruby
Graphenedb.databases
```

To get a single database:
```ruby
Graphenedb.database('database-id')
```

To empty a database:

```ruby
Graphenedb.empty_database('database-id')
```

To restart a database:

```ruby
Graphenedb.restart_database('database-id')
```

To create a database:

```ruby
Graphenedb.create_database('database-name')

# you can also use a hash to specify config:
Graphenedb.create_database(name: 'name', region: 'us-west-2')

# config defaults: {version: 'v314', region: 'us-east-1', plan: 'sandbox'}
```
> * version: must be a valid version identifier from Graphenedb.versions
> * region: aws region [us-east-1, us-west-1, us-west-2, ca-central-1, eu-west-1, eu-west-2, eu-central-1, ap-northeast-1, ap-southeast-1, ap-southeast-2]
> * plan: [sandbox, developer0, s1, s2, p1, p2, p3, p4]

To clone a database:

```ruby
Graphenedb.clone_database('database-id', 'new-database-name')

# you can also use a hash to specify config:
Graphenedb.clone_database(id: 'id', name: 'name', region: 'us-west-2')

# config defaults: {version: 'v314', region: 'us-east-1', plan: 'sandbox'}
```
> * version: must be a valid version identifier from Graphenedb.versions
> * region: aws region [us-east-1, us-west-1, us-west-2, ca-central-1, eu-west-1, eu-west-2, eu-central-1, ap-northeast-1, ap-southeast-1, ap-southeast-2]
> * plan: [sandbox, developer0, s1, s2, p1, p2, p3, p4]

To delete a database:

```ruby
Graphenedb.delete_database('id')
```

---

To get all database users:

```ruby
Graphenedb.users('database-id')
```

To get a single database user:

```ruby
Graphenedb.user('database-id', 'user-id')
```

To create a database user:

```ruby
# pass in a name for the new database
Graphenedb.create_user('database-id', 'description')
# note: based on graphenedb's api, "description" is set as the "username" as well, so it might be a bit confusing, but set this value to what you want the username to be.

# you can also use a hash to specify config:
Graphenedb.create_user(id: 'database-id', description: 'description', expire_at: "yyyy-MM-dd'T'HH:mm:ss'Z'")
# config defaults: {expire_at: 'never'}
```

To delete a database user:

```ruby
Graphenedb.delete_user('database-id', 'user-id')
```

---

> Note: For backups support, the DB plan must be S1 or better.

To list all database backups:

```ruby
Graphenedb.backups('database-id')
```

To get a single database backup:

```ruby
Graphenedb.backup('database-id', 'backup-id')
```

To get database backup URL:

```ruby
Graphenedb.backup('database-id', 'backup-id')
```

To get database backup URL:

```ruby
Graphenedb.backup('database-id', 'backup-id')
```

To list all database backup schedules:

```ruby
Graphenedb.all_backup_schedules('database-id')
```

To list database backup schedules within timeframe:

```ruby
Graphenedb.backup_schedules(id: 'database-id', time: '04:20:00', timezone: 'UTC', frequency: 'daily')
```
> The body params must follow the correct format:
> * time: String-formatted time in HH:MM:SS, eg. 04:20:00
> * timezone: only [UTC].
> * frequency: only [daily] backups.


To create manual backup (snapshot) of database:

```ruby
Graphenedb.snapshot('database-id')
```

Restore backup to database:

```ruby
Graphenedb.restore_backup('database-id', 'backup-id')
```

Import backup to database:

```ruby
Graphenedb.import('database-id', 'url-of-backup')

Graphenedb.import(id: 'database-id', url: 'url-of-backup')
```
> * url: Link to S3 graphdb.zip

---

### TODO
* Automated tests (important)



### Questions or Problems?

[Create a new issue](https://github.com/rickybrown/graphenedb/issues) on Github and/or [submit a pull request](https://github.com/rickybrown/graphenedb/pulls) :)
