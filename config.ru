require 'sass/plugin/rack'
require_relative 'infanciasulamericana'

Sass::Plugin.options[:style] = :compressed
Sass::Plugin.options[:template_location] = 'assets/css'

use Sass::Plugin::Rack
run Sinatra::Application
