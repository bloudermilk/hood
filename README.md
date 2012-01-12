# Hood

**Hood is currently in alpha development. Our feature-set isn't fully developed,
our specs are weak, and there are probably bugs.**

Hood is to enviroment variables as bundler is to gems. To put it simply, we have
the following goals:

* Serve as a means to document all enviroment variables for a given Ruby or
  Rails project.
* Give developers an easy way to ensure the presence of required variables
* Streamline the process of bootstrapping a new environment

## Envfile

Hood uses something called an "Envfile" to define environment variables. It uses
a DSL (Domain Specific Language) similar to Bundler's to do so:

```ruby
env "GOOGLE_MAPS_API_KEY"

env "REDIS_URI", :default => "localhost:6379"

env "SALES_TAX", :description => "Current sales tax in Los Angeles (eg. 0.0875)"

prefix "DB_" do
  env "PASSWORD"
  env "USER"
  env "DATABASE"
  env "SOCKET"
  env "ADAPTER"
end
```

## Options
* `:description` If the desired value isn't obvious, you can include a string
* `:optional` Pass true to avoid throwing a runtime error when the app starts and this var isn't present
* `:default` A pre-defined default value for this var

## Compatibility

Hood is tested against the following Rubies: MRI 1.8.7, MRI 1.9.2, MRI 1.9.3,
Rubinius 2.0, and JRuby.

![Build Status](https://secure.travis-ci.org/bloudermilk/hood.png?branch=master&.png)

[Build History](http://travis-ci.org/#!/bloudermilk/hood)


## License

Hood is released under the MIT license. See the LICENSE file for more
info.
