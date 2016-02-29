class CreateJoinTableFactsRubrics < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_facts_rubrics, :id => false do |t|
      t.integer :fact_id, :null => false
      t.integer :rubric_id, :null => false
    end

    # Add table index
    add_index :c80_news_tz_facts_rubrics, [:fact_id, :rubric_id], :unique => true

  end
end
