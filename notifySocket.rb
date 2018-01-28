require 'em-websocket'
require 'json'
require 'net/http'
require 'uri'

connections = []

EM.run {
  EM::WebSocket.run(:host => "0.0.0.0", :port => 8888) do |ws|
    ws.onopen {
      puts "WebSocket connection open"
    }

    ws.onclose {
        puts "Connection closed"
        connections.reject!{|conn| conn[:ws] == ws };
        puts "conn_count:#{connections.length}"
    }

    ws.onmessage { |msg|
        msgObj = JSON.parse(msg);
        puts msg;
        puts msgObj["isOpenMsg"]
        if msgObj["isOpenMsg"] then
            puts "connect"
            connections << { ws: ws , employeeId: msgObj["employeeId"] }
            puts "conn_count:#{connections.length}"
        elsif msgObj["yabee"] then
            url = "http://localhost:4567/api/free"
            res = Net::HTTP.get(URI.parse(url))
            himas = JSON.parse(res);

            connections.reject{|conn| himas.include?(conn[:employeeId]) == "false" || conn[:ws] == ws }.each{|conn| conn[:ws].send("#{msgObj["msg"]}さんがマジやべぇです！") }
        end
    }
  end
}