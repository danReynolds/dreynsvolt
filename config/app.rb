Volt.configure do |config|
  # Setup your global app config here.

  # Your app secret is used for signing things like the user cookie so it can't
  # be tampered with.  A random value is generated on new projects that will work
  # without the need to customize.  Make sure this value doesn't leave your server.
  config.app_secret = 'zYZkz0vjyU4aSoZ3JqwP-2gwhJjZSmjzpqPpz7zTrDM6PzFvph_tb0ItXc3nd6Sg5A4'

  # The app name defaults to the folder it is run in.
  # config.app_name = 'dreynsvolt'

  # Database config all start with db_ and can be set either in the config
  # file or with an environment variable (DB_NAME for example).

  # config.db_driver = 'mongo'
  # config.db_name = (config.app_name + '_' + Volt.env.to_s)
  # config.db_host = 'localhost'
  # config.db_port = 27017

  # Compression options

  # If you are not running behind something like nginx in production, you can
  # have rack deflate all files.
  # config.deflate = true
end