ActiveAdmin.register C80NewsTz::Spot, :as => 'Spot' do

  menu :label => "Рубрики на главной", :parent => 'Содержимое сайта'

  before_filter :skip_sidebar!, :only => :index

  permit_params :rubric_ids => []

  config.sort_order = 'id_asc'

  index do
    id_column
    column :title

    column :rubrics do |loc|
      # нарисуем список
      list_items = ((loc.rubrics.map { |p|
        "<li>• #{ p.title } <a href='/rubrics/#{p.slug}' target='_blank'>[view]</a> <a href='/admin/rubrics/#{p.slug}/edit'>[edit]</a> </li>"
      }).join("")).html_safe

      "<ul>#{list_items}</ul>".html_safe
    end

    actions
  end

  form(:html => {:multipart => true}) do |f|
    f.inputs "Свойства" do
      f.input :title

      f.input :rubrics,
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