Teleporter
----------
Rails generators for a fresh application

[![Gem Version](https://badge.fury.io/rb/teleporter.svg)](http://badge.fury.io/rb/teleporter)


Table of content
----------------
* [rails g initial:start](#rails-g-initialstart)
  * [rails g initial:gemfile](#rails-g-initialgemfile)
  * [rails g initial:gitignore](#rails-g-initialgitignore)
  * [rails g initial:database](#rails-g-initialdatabase)
  * [rails g initial:rspec](#rails-g-initialrspec)
  * [rails g initial:welcome](#rails-g-initialwelcome)
  * [rails g initial:capistrano](#rails-g-initialcapistrano)
  * [rails g initial:bootstrap](#rails-g-initialbootstrap)
  * [rails g initial:simple_form](#rails-g-initialsimple_form)
  * [rails g initial:devise](#rails-g-initialdevise)
    * [rails g initial:devise_oauth](#rails-g-initialdevise_oauth)

## rails g initial:start
```shell
$ rails g initial:start
```
runs all generators below

### rails g initial:gemfile
```shell
$ rails g initial:gemfile
```
adds gemfiles: `russian`, `sidekiq`, `puma`, `haml-rails`, `therubyracer`, `quiet_assets`
adds timezone and locale
```ruby
  config.time_zone = 'Moscow'
  config.i18n.default_locale = :ru
```

### rails g initial:gitignore
copies template for `.gitignore` file with all common excludes

### rails g initial:database
`database.yml` for postgresql and `rake db:create`

### rails g initial:rspec
adds gems `rspec-rails`, `spring`, `sping-commands-rspec`, `factory_girl_rails`, `capybara`, `database_cleeaner`, `shoulds-matchers`, `poltergeist`, `phantomjs`, `vcr`, `webmock`
and configures them all for a testing rails app

### rails g initial:welcome
generates `WelcomeController#index` and uses it as `root_path`

### rails g initial:capistrano
adds gems: `capistrano`, `capistrano-rbenv`, `capistrano-bundler`, `capistrano-rails`, `capistrano-sidekiq`, `capistrano-puma`
generate Capistrano 3 configs for deployment

### rails g initial:bootstrap
adds gems `bootstrap-sass`, `kaminari-bootstrap`, `bh`, `autoprefixer-rails`
binds them with a fresh rails application

### rails g initial:simple_form
adds gem `simple-form`
generates wrappers for: `Basic` | `Bootstrap` | `Zurb`

### rails g initial:devise
adds gems: `devise`, `cancancan`, `letter-opener`
generates files for devise installation into a fresh rails application

#### rails g initial:devise_oauth
generates files for devise-oauth providers
