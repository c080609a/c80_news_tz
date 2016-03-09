class CreateJoinTableAdvertisersLives < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_advs_lives, :id => false do |t|
      t.integer :r_advertiser_id, :null => false
      t.integer :r_live_id, :null => false
    end

    # Add table index
    add_index :c80_news_tz_advs_lives, [:r_advertiser_id, :r_live_id], :unique => true

  end
end
