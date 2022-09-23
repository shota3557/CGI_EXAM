require 'webrick'

server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.mount('', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')

server.mount('/quality.cgi', WEBrick::HTTPServlet::CGIHandler, 'quality.rb')

# この一行を追記
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

server.start
