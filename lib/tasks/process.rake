require 'open-uri'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

desc "Process"
task :process, [:start, :count] => :environment do |t, args|
  start = args[:start].to_i
  count = args[:count].to_i

  (start..(start+count-1)).each do |t_id|
    puts "Attempting " + t_id.to_s
    trip = Trip.find(t_id)
    response = open(trip.generate_url)
    trip.populate_from_json(response.read)
    trip.save
  end
end