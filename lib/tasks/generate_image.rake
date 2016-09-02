desc "Generate Image"
task :generate_image  => :environment do
  trip = Trip.find(3)
  points = Polylines::Decoder.decode_polyline(trip.polyline)
  img = ChunkyPNG::Image.new(256, 256, ChunkyPNG::Color::WHITE)
  r = 0
  points.each do |point|
    trip_width = trip.northeast_bound_lat - trip.southeast_bound_lat
    trip_height = trip.northeast_bound_lon - trip.southeast_bound_lon
    adjusted_lat = point[0] - trip.southeast_bound_lat
    adjusted_lon = trip.northeast_bound_lon - point[1]
    scaled_lat = adjusted_lat / trip_width
    scaled_lon = adjusted_lon / trip_height
    puts scaled_lat.to_s
    puts scaled_lon.to_s
    if(scaled_lat < 0) then scaled_lat = 0 end
    if(scaled_lon < 0) then scaled_lon = 0 end
    x = (255 * scaled_lat).floor
    y = (255 * scaled_lon).floor
    r += 1
    img[x,y] = ChunkyPNG::Color.rgba((255 / points.size) * r, 0, 0, 255)
  end
  img.save("hi.png")
end