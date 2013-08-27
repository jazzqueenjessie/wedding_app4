class Rsvp
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActionView::Helpers::TextHelper
  
  attr_accessor :firstname1, :lastname1, :no1, :yes1,
                :firstname2, :lastname2, :no2, :yes2,
                :firstname3, :lastname3, :no3, :yes3,
                :firstname4, :lastname4, :no4, :yes4,
                :firstname5, :lastname5, :no5, :yes5,
                :email, :phone, :notes, :nickname
  
  validates :firstname1,
            :presence => true

  validates :lastname1,
            :presence => true
  
  validates :email,
            :presence => true,
            :format => { :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }
  
  validates :nickname,
            :format => { :with => /^$/ }
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def deliver
    return false unless valid?
    Pony.mail({
      :from => %("#{firstname1} #{lastname1}" <#{email}>),
      :reply_to => email,
      :subject => "Website RSVP",
      :body => "#{firstname1} #{lastname1} #{yes1} #{no1}",
      :html_body => simple_format(make_message)
    })
  end

  def make_message
    message = ""
    yes = [yes1, yes2, yes3, yes4, yes5]
    no = [no1, no2, no3, no4, no5]
    first = [firstname1, firstname2, firstname3, firstname4, firstname5]
    last = [lastname1, lastname2, lastname3, lastname4, lastname5]
    
    for n in 0..4
      guest = first[n]+ ' ' + last[n]
      if guest != ' '

        if yes[n] == '1'
          guest = guest + ' - accepted'
        end

        if no[n] == '1'
            guest = guest + ' - declined'
        end

        message = message + guest + "\n"
      end
    end

    return message
  end
  
  def persisted?
    false
  end
end
