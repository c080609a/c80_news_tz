ActiveAdmin.register C80NewsTz::Banner02, :as => 'Banner02' do

  menu :label => "Рекламный блок №2", :parent => 'Баннеры'

  permit_params :title,
                :image,
                :href,
                :is_active

  config.sort_order = 'title_asc'

  filter :title
  filter :href
  filter :is_active

  # controller do
  #   cache_sweeper :suit_sweeper, :only => [:update,:create,:destroy]
  # end

  index do
    selectable_column
    id_column
    column :title
    column :image do |a|
      if a.image.present?
        "#{image_tag("#{a.image.thumb_preview.url}")}".html_safe
      end
    end
    column :href
    column :is_active
    column :shown
    column :clicks

    actions
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs "Свойства" do

      f.input :title
      f.input :href
      f.input :image, :hint => "#{image_tag("#{f.object.image.thumb_preview.url}")}".html_safe
      f.input :is_active
    end

    f.actions
  end

end