# README

## Ruby version

2.7.2

## System dependencies


## Configuration


## How to install

```
yarn install --check-files
bundle config set path 'vendor/bundle'
bundle install
bundle exec rails db:create db:migrate db:seed
```

## How to run the app

```
bundle exec rails s
```

Access http://localhost:3000


## How to run the test suite

```
bundle exec rails test test/**/*_test.rb
```

### Coverage

```
# run after runing the test suite.
open coverage/index.html
```

## Services (job queues, cache servers, search engines, etc.)


## Deployment instructions


## Licence

* なし（個人的に許可された方以外の再利用、再配布は禁止です）

## Author

[daiki.tanaka.g](https://github.com/daiki.tanaka.g)
