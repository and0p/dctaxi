desc "Import"
task :import  => :environment do
  s = SimpleSpreadsheet::Workbook.read("c:\\users\\and0\\downloads\\sample trip data.xls")
  total = 0
  saved = 0
  puts "Starting..."
  (2..53121).each do |line|
    trip = Trip.new
    trip.tdms_id = s.cell(line, 1)
    trip.provider_type = s.cell(line, 2)
    trip.provider = s.cell(line, 3)
    trip.fare = s.cell(line, 4)
    trip.tip = s.cell(line, 5)
    trip.surcharge = s.cell(line, 6)
    trip.extras = s.cell(line, 7)
    trip.tolls = s.cell(line, 8)
    trip.total = s.cell(line, 9)
    trip.payment_type = s.cell(line, 10).to_s.downcase
    trip.payment_provider = s.cell(line, 11).to_s.downcase
    trip.pickup_time = s.cell(line, 12)
    trip.dropoff_time = s.cell(line, 13)
    trip.pickup_address = s.cell(line, 14).to_s.tr('\"', '')
    trip.pickup_city = s.cell(line, 15).to_s.tr('\"', '')
    trip.pickup_state = s.cell(line, 16)
    trip.pickup_postcode = s.cell(line, 17).to_s[0..4]
    trip.dropoff_address = s.cell(line, 18).to_s.tr('\"', '')
    trip.dropoff_city = s.cell(line, 19).to_s.tr('\"', '')
    trip.dropoff_state = s.cell(line, 20)
    trip.dropoff_postcode = s.cell(line, 21).to_s[0..4]
    trip.mileage = s.cell(line, 22)
    trip.time = s.cell(line, 23)

    if(trip.pickup_time != nil)
      trip.start_date = trip.pickup_time.to_date
    end

    trip.clean_addresses
    total += 1
    if trip.check_addresses? then
      if trip.save then
        saved += 1
        puts "Saved " + trip.tdms_id.to_s + " as " + trip.id.to_s
      end
    end
    puts "That's " + saved.to_s + " out of " + total.to_s
  end
end