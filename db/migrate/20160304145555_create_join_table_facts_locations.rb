class CreateJoinTableFactsLocations < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_facts_locations, :id => false do |t|
      t.integer :fact_id, :null => false
      t.integer :location_id, :null => false
    end

    # Add table index
    add_index :c80_news_tz_facts_locations, [:fact_id, :location_id], :unique => true

  end
end
