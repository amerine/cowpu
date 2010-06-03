module Rack 
  class TrackingCode
    
    TRACKING_CODE = <<-EOTC 
    <script src="http://static.getclicky.com/js" type="text/javascript"></script>
    <script type="text/javascript">clicky.init(220101);</script>
    <noscript><p><img alt="Clicky" width="1" height="1" src="http://in.getclicky.com/220101ns.gif" /></p></noscript>
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
        response.write(inject_tracking(fragment))
      end
      response.finish
    end
    
    def inject_tracking(response)
        response.sub!(/<\/body>/, "#{TRACKING_CODE}\n</body>")
    end
    
  end
  
end