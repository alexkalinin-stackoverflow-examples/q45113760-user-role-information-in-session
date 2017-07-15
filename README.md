[question](https://stackoverflow.com/questions/45113760/how-to-customise-devise-to-store-user-role-information-in-session)

### Setup

```
bundle install
rake db:create db:migrate db:seed 
rails server
```


### Test

```
rspec
```


### Documentation

`rake db:seed` will create 3 users with different roles:

* `reader@mail.com` with password `123123123` - can read everybodie's post. Cannot create or delete any.
* `writer@mail.com` with password `123123123` - can create/update/delete own posts. Cannot read/update/delete foreign.
* `admin@mail.com` with password `123123123` - can do everything.

See `spec/controllers/posts_controller_spec.rb` test for details