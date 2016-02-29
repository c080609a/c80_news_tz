class CreateJoinTableCompaniesNotices < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_companies_notices, :id => false do |t|
      t.integer :company_id, :null => false
      t.integer :notice_id, :null => false
    end

    # Add table index
    add_index :c80_news_tz_companies_notices, [:notice_id, :company_id], :unique => true

  end
end
