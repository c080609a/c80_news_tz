ActiveAdmin.register C80NewsTz::RLive, :as => 'RLive' do

  menu :label => "Рекламодатель активный", :parent => 'Содержимое сайта'

  before_filter :skip_sidebar!, :only => :index

  # permit_params :fact_ids => []

  config.sort_order = 'id_asc'

  index do
    #id_column
    #column :title

=begin
    column :facts do |loc|
      # нарисуем список
      list_items = ((loc.facts.map { |p|
        "<li>• #{ p.title } <a href='/news/#{p.slug}' target='_blank'>[view]</a> <a href='/admin/facts/#{p.slug}/edit'>[edit]</a> </li>"
      }).join("")).html_safe

      "<ul>#{list_items}</ul>".html_safe
    end
=end

    actions
  end

  form(:html => {:multipart => true}) do |f|
    f.inputs "Свойства" do
      #f.input :title

=begin
      f.input :facts,
              :as => :select,
              :input_html => {:multiple => false},
              :include_blank => true,
              :member_label => Proc.new { |p|
                p.title
              }
=end

    end
    f.actions
  end

end