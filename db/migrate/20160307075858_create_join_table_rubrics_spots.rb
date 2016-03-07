class CreateJoinTableRubricsSpots < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_rubrics_spots, :id => false do |t|
      t.integer :rubric_id, :null => false
      t.integer :spot_id, :null => false
    end

    # Add table index
    add_index :c80_news_tz_rubrics_spots, [:rubric_id, :spot_id], :unique => true

  end
end
