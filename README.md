[question](https://stackoverflow.com/questions/45113760/how-to-customise-devise-to-store-user-role-information-in-session)

### Solutions

See [Pull Requests](https://github.com/alexkalinin-stackoverflow-examples/q45113760-user-role-information-in-session/pulls?utf8=%E2%9C%93&q=is%3Apr%20) diffs and it's branches to view solution. 

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