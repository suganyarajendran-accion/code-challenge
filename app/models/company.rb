class Company < ApplicationRecord
  has_rich_text :description
  validates_format_of :email,
    :with => /\A[A-Za-z0-9+_.-]+@getmainstreet\.com\z/i,
    :allow_blank => true,
    :message => "should contains '@getmainstreet.com' OR can be blank"
  before_save :set_city_and_state, if: :zip_code_changed?

  private

  def set_city_and_state
    zipcode_data = ZipCodes.identify(zip_code)
  	if zipcode_data.present?
      assign_attributes(city: zipcode_data[:city], state: zipcode_data[:state_code])
    else
      assign_attributes(city: nil, state: nil)
    end
  end
end
