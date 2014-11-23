# See https://github.com/voltrb/volt#routes for more info on routes

get '/about', _action: 'about'
get '/social', _action: 'social'
get '/recreation', _action: 'recreation'
get '/programming', _action: 'programming'

# The main route, this should be last.  It will match any params not previously matched.
get '/', {}
