class CreateJoinTableBlurbsIssues < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_blurbs_issues, :id => false do |t|
      t.integer :issue_id, :null => false
      t.integer :r_blurb_id, :null => false
    end

    # Add table index
    add_index :c80_news_tz_blurbs_issues, [:issue_id, :r_blurb_id], :unique => true

  end
end
