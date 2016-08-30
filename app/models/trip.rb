class Trip < ActiveRecord::Base
  has_many :steps
  validates :tdms_id, presence: true
  validates :provider_type, presence: true
  validates :provider, presence: true
  validates :fare, presence: true
  validates :tip, presence: true
  validates :surcharge, presence: true
  validates :extras, presence: true
  validates :tolls, presence: true
  validates :total, presence: true
  validates :payment_type, presence: true
  validates :payment_provider, presence: true
  validates :start_date, presence: true
  validates :pickup_time, presence: true
  validates :dropoff_time, presence: true
  validates :pickup_time, presence: true
  validates :dropoff_time, presence: true
  validates :pickup_address, presence: true
  validates :pickup_state, presence: true
  validates :pickup_postcode, presence: true
  validates :dropoff_address, presence: true
  validates :dropoff_state, presence: true
  validates :dropoff_postcode, presence: true
  validates :mileage, presence: true
  validates :time, presence: true

  validates  :pickup_address, length: { minimum: 4 }
  validates  :dropoff_address, length: { minimum: 4 }

  def check_addresses?
      if (pickup_address.length <= 5 || dropoff_address.length <= 5)
        return false
      end
      if (pickup_address[0..7] == "building" || dropoff_address[0..7] == "building")
        return false
      end
      if !(((pickup_address.include? "@") || (pickup_address =~ /\d/) != nil ) && ((dropoff_address.include? "@") || (dropoff_address =~ /\d/ ) != nil))
        return false
      end
      return true
  end

  def clean_addresses
    if(pickup_address.downcase.include? "aviation") then pickup_address = "Aviation Circle" end
    if(dropoff_address.downcase.include? "aviation") then dropoff_address = "Aviation Circle" end
  end

  def populate_from_json(json_string)
    json = JSON.parse(json_string)
    # Make sure we actually got results
    if(json["status"] != "OK") then return false end
      # TODO lets record if Maps API fails to recognize trip
    # Get bounds
    northeast_lat = json["routes"][0]["bounds"]["northeast"]["lat"]
    northeast_lon = json["routes"][0]["bounds"]["northeast"]["lng"]
    southwest_lat = json["routes"][0]["bounds"]["southwest"]["lat"]
    southwest_lon = json["routes"][0]["bounds"]["southwest"]["lng"]
    # Grab the overview polyline
    polyline = json["routes"][0]["overview_polyline"]["points"]
    # Grab all individual legs of trip as Steps
    json["routes"][0]["legs"][0]["steps"].each do |json_step|
      step = build_step
      step.distance = json_step["distance"]["value"]
      step.duration = json_step["duration"]["value"]
      step.start_lat = json_step["start_location"]["lat"]
      step.start_lon = json_step["start_location"]["lng"]
      step.end_lat = json_step["end_location"]["lat"]
      step.end_lon = json_step["end_location"]["lng"]
      step.instructions = json_step["html_instructions"]
      step.polyline = json_step["polyline"]["points"]
      step.save
    end
  end
end
