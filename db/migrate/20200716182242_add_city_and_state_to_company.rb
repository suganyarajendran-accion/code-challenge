class AddCityAndStateToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :city, :string
    add_column :companies, :state, :string
    Company.all.each do |c|
      c.send(:set_city_and_state)
      c.save!(:validate => false)
    end
  end
end
