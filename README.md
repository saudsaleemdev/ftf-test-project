# FTF Assessments

## Install
### Clone the repository

```shell
git clone https://github.com/saudsaleemdev/ftf-test-project.git
cd ftf-test-project
```
### Dependencies

* `ruby -> 3.0.0 `
* `rails -> 7.0.6`
* You should have postgres installed on your system - [see here for more info](https://www.postgresql.org/download/macosx/)
### Check your Ruby version

```shell
ruby -v
```

You should expect `ruby 3.0.0`

If not, install the right ruby version using [rvm](https://rvm.io/) (it could take a while):

```shell
rvm install 3.0.0
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle install
```

### Initialize the database

```shell
rails db:setup
```
## Server

```shell
rails s
```
