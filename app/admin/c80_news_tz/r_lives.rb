ActiveAdmin.register C80NewsTz::RLive, :as => 'RLive' do

  menu :label => "Рекламодатель активный", :parent => 'Содержимое сайта'

  before_filter :skip_sidebar!, :only => :index

  permit_params :r_advertiser_ids => []

  index do
    column :r_advertisers do |loc|
      # нарисуем список
      list_items = ((loc.r_advertisers.map { |p|
        "<li>#{ p.title }</li>"
      }).join("")).html_safe

      "<ul>#{list_items}</ul>".html_safe
    end
    actions
  end

  form(:html => {:multipart => true}) do |f|
    f.inputs "Свойства" do

      f.input :r_advertisers,
              :as => :select,
              :input_html => {:multiple => false},
              :include_blank => true,
              :member_label => Proc.new { |p|
                p.title
              }

    end
    f.actions
  end

end