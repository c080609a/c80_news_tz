class CreateFacts < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_facts, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :title
      t.string :sub_title
      t.text :short
      t.text :leader_abz
      t.text :full
      t.string :keywords
      t.string :description
      t.string :slug

      t.timestamps
    end
  end
end