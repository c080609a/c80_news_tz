class CreateJoinTableBlurbsRubrics < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_blurbs_rubrics, :id => false do |t|
      t.integer :r_blurb_id, :null => false
      t.integer :rubric_id, :null => false
    end

    # Add table index
    add_index :c80_news_tz_blurbs_rubrics, [:r_blurb_id, :rubric_id], :unique => true

  end
end
