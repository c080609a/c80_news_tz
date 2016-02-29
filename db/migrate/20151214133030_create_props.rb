class CreateProps < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_props, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.integer :per_page
      t.integer :per_widget
      t.timestamps
    end
  end
end