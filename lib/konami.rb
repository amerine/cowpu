module Rack 
  class KonamiCode
    
    KONAMI_CODE = <<-EOTC 
    <div id="cowpoo" style="display:none;position:fixed;top:20%;right:50%;">
      <img src="/images/cow-poo.jpg" alt="Cow Poop!" />
    </div>
    <script type="text/javascript" src="http://konami-js.googlecode.com/svn/trunk/konami.js"></script>
    <script type="text/javascript">
    	konami = new Konami()
    	konami.code = function() {
        $('#cowpoo').fadeIn('slow');
        $('#cowpoo').fadeOut('slow');
      }
    	konami.load()
    </script>
    EOTC
    
    def initialize(app, options = {})
      @app = app
    end
    
    def call(env)
      dup._call(env)
    end
    
    def _call(env)
      
      @status, @headers, @response = @app.call(env)
      return [@status, @headers, @response] unless @headers['Content-Type'] =~ /html/

      @headers.delete('Content-Length')
      response = Rack::Response.new([], @status, @headers)
      @response.each do |fragment|
        response.write(inject_konami(fragment))
      end
      response.finish
    end
    
    def inject_konami(response)
        response.sub!(/<\/body>/, "#{KONAMI_CODE}\n</body>")
    end
    
  end
  
end