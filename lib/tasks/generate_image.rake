desc "Generate Image"
task :generate_image  => :environment do
  image_size = 3840
  canvas = ChunkyPNG::Canvas.new(image_size, image_size, ChunkyPNG::Color::WHITE)
  image_top_left		  = [39.14201825, -77.26847825]
  image_bottom_right	= [38.67060575, -76.79706575]
  image_size_geo      = 0.4714125
  drawn = 0
  Trip.all.each do |trip|
    if trip.mappable && trip.processed && trip.mileage < 5 then
      pixel_coords = []
      points = Polylines::Decoder.decode_polyline(trip.polyline)
      # Append each point's true x&y pixel coordinates to a list for easier line drawing
      points.each do |point|
        distance_from_right   = image_bottom_right[1] - point[1]
        distance_from_bottom  = point[0] - image_bottom_right[0]
        distance_from_left    = image_size_geo - distance_from_right
        distance_from_top     = image_size_geo - distance_from_bottom
        left_normalized       = distance_from_left / image_size_geo
        top_normalized        = distance_from_top / image_size_geo
        x = (image_size * left_normalized).floor
        y = (image_size * top_normalized).floor
        if x > image_size - 1 then x = image_size - 1 end
        if y > image_size - 1 then y = image_size - 1 end
        if x < 0 then x = 0 end
        if y < 0 then y = 0 end
        pixel_coords << [x,y]
      end
      # Draw lines for each successive pair of pixel coordinates
      (0..pixel_coords.count - 2).each do |p|
        coords = pixel_coords[p]
        next_coords = pixel_coords[p+1]
        canvas.line(coords[0], coords[1], next_coords[0], next_coords[1], ChunkyPNG::Color.rgba(0, 0, 0, 20), false)
        #ChunkyPNG::Color.rgba(10, 20, 30, 128)
      end
      drawn += 1
    end
  end
  puts drawn
  img = canvas.to_image
  img.save("hi.png")
end