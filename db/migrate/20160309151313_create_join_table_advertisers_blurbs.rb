class CreateJoinTableAdvertisersBlurbs < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_advs_blurbs, :id => false do |t|
      t.integer :r_advertiser_id, :null => false
      t.integer :r_blurb_id, :null => false
    end

    # Add table index
    add_index :c80_news_tz_advs_blurbs, [:r_advertiser_id, :r_blurb_id], :unique => true

  end
end
