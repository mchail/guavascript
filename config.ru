
require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/img', '/favicon.ico', '/robots.txt'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  # 
  set :author,    "Steve McHail"
  set :title,     "Guavascript"                   # site title
  # set :root,      "index"                                   # page to load on /
  set :markdown,  :smart                                    # use markdown + smart-mode
  set :disqus,    "guavascript"                                     # disqus id, or false
  set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  set :ext,       'txt'                                     # file extension for articles
  # set :cache,      28800                                    # cache duration, in seconds

  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
end

run toto


