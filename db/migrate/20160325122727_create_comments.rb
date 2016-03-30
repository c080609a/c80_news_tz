class CreateComments < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_comments, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.text :message, :limit => 1100
      t.references :fact, :index => true
      t.references :r_blurb, :index => true
      t.references :user, :index => true
      t.string :user_name # если удалить пользователя - здесь сохранится его имя
      t.timestamps
    end
  end
end