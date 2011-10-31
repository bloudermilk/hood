# Hood

*Hood is currently in alpha development. Our feature-set isn't fully developed,
our specs are weak, and there are probably bugs.*

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
env "GOOGLE_MAPS_API_KEY", required: true

prefix "DB_" do
  env "PASSWORD"
  env "USER"
  env "DATABASE"
  env "SOCKET"
  env "ADAPTER"
end
```

## Options
* :description - If the desired value isn't obvious, you can include a string
* :optional - Pass true to avoid throwing a runtime error when the app starts and this var isn't present
* :prefix - Prefixes the group (or env I guess) with the passed string. Useful when you have a group where all vars have the same prefix
* :default - A pre-defined default value for this var
