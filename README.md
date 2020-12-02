# README

## How to get the application up and running.

### Method 1. With Docker

1. Make you sure you have [docker](https://www.docker.com/) installed

2. Install dependencies and set up your DB inside docker environment

```
docker-compose run --rm runner bundle
docker-compose run --rm runner yarn
docker-compose run --rm runner bin/rails db:setup
```

> Important note: docker-compose run --rm runner bundle might take up to 10+ minutes to finish, please be patient and do not force stop it, or you will have to rebuild sassc like this: gem pristine sassc


3. Start the server

```
docker-compose up rails
```

4. Visit http://localhost:3000

### Method 2. Manual

1. Make sure you have installed the following:

- ruby
- node
- postgres

> If you use Linux, here's the great guides: 
https://ryanbigg.com/2014/10/ubuntu-ruby-ruby-install-chruby-and-you
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04

2. Install dependencies

```
bundle
```

```
yarn
```

3. Set up the DB

```
rails db:setup
```

4. Start the server

```
rails s
```

5. Visit http://localhost:3000
