class CreateJoinTableFactsIssues < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_facts_issues, :id => false do |t|
      t.integer :fact_id, :null => false
      t.integer :issue_id, :null => false
    end

    # Add table index
    add_index :c80_news_tz_facts_issues, [:fact_id, :issue_id], :unique => true

  end
end
