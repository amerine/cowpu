require ::File.dirname(__FILE__) + '/config/boot.rb'
require ::File.dirname(__FILE__) + '/lib/konami.rb'
use Rack::TrackingCode
use Rack::KonamiCode
run Padrino.application
