class Rsvp
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  
  arrt_accessor :name, :email, :message
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def deliver
    true
  end
  
  def persisted?
    false
  end
end
