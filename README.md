Teleporter
----------
Generators for a fresh Rails application

[![Gem Version](https://badge.fury.io/rb/teleporter.svg)](http://badge.fury.io/rb/teleporter)


Table of content
----------------
* [rails g teleport:start](#rails-g-teleportstart)
  * [rails g teleport:gemfile](#rails-g-teleportgemfile)
  * [rails g teleport:gitignore](#rails-g-teleportgitignore)
  * [rails g teleport:database](#rails-g-teleportdatabase)
  * [rails g teleport:rspec](#rails-g-teleportrspec)
  * [rails g teleport:welcome](#rails-g-teleportwelcome)
  * [rails g teleport:capistrano](#rails-g-teleportcapistrano)
  * [rails g teleport:bootstrap](#rails-g-teleportbootstrap)
    * [rails g teleport:bootstrap:navbar](#rails-g-teleportbootstrapnavbar)
  * [rails g teleport:simple_form](#rails-g-teleportsimple_form)
  * [rails g teleport:devise](#rails-g-teleportdevise)
    * [rails g teleport:devise_oauth](#rails-g-teleportdevise_oauth)
  * [rails g teleport:api](#rails-g-teleportapi)
  * [rails g teleport:sidekiq](#rails-g-teleportsidekiq)
  * [rails g teleport:redactor_rails](#rails-g-teleportredactor_rails)

## rails g teleport:start
```shell
$ rails g teleport:start
```
runs all generators below

### rails g teleport:gemfile
```shell
$ rails g teleport:gemfile
```
adds gemfiles: `russian`, `puma`, `haml-rails`, `therubyracer`, `quiet_assets`
adds timezone and locale
```ruby
  config.time_zone = 'Moscow'
  config.i18n.default_locale = :ru
```

### rails g teleport:gitignore
copies template for `.gitignore` file with all common excludes

### rails g teleport:database
`database.yml` for postgresql and `rake db:create`

### rails g teleport:rspec
adds gems `rspec-rails`, `spring`, `sping-commands-rspec`, `factory_girl_rails`, `capybara`, `database_cleeaner`, `shoulds-matchers`, `poltergeist`, `phantomjs`, `vcr`, `webmock`
and configures them all for a testing rails app

### rails g teleport:welcome
generates `WelcomeController#index` and uses it as `root_path`

### rails g teleport:capistrano
adds gems: `capistrano`, `capistrano-rbenv`, `capistrano-bundler`, `capistrano-rails`, `capistrano-sidekiq`, `capistrano-puma`
generate Capistrano 3 configs for deployment
add tasks

### rails g teleport:bootstrap
adds gems `bootstrap-sass`, `kaminari-bootstrap`, `bh`, `autoprefixer-rails`
binds them with a fresh rails application

#### rails g teleport:bootstrap:navbar
adds `_navbar.haml` file to a project

### rails g teleport:simple_form
adds gem `simple-form`
generates wrappers for: `Basic` | `Bootstrap` | `Zurb`

### rails g teleport:devise
adds gems: `devise`, `cancancan`, `letter-opener`
generates files for devise installation into a fresh rails application

#### rails g teleport:devise_oauth
generates files for devise-oauth providers

#### rails g teleport:api
generates `api/v1/. . .` files for json api
adds routes for subdomain `api.example.com`
adds `gem jsonbuilder`

#### rails g teleport:sidekiq
adds `sidekiq` and `sidetiq` to rails project
adds routes to mount /sidekiq monitoring
adds templates for worker class for sidekiq and sidekiq


#### rails g teleport:redactor_rails
setups `redactor_rails` gem in application
