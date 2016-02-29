class CreateAdresses < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_adresses, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :locality
      t.string :street
      t.string :telephone_1
      t.string :telephone_2
      t.string :telephone_3
      t.string :latitude
      t.string :longitude
      t.string :email_1
      t.string :email_2
      t.string :site_1
      t.string :site_2
      t.references :company, :index => true
      t.references :notice, :index => true

      t.timestamps
    end
  end
end