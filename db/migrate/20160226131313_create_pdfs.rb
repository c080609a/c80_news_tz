class CreatePdfs < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_pdfs, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :file
      t.references :issue, index: true

      t.timestamps null: false
    end

  end
end