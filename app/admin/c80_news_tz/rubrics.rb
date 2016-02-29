ActiveAdmin.register C80NewsTz::Rubric, :as => 'Rubric' do

  menu :label => "Рубрики", :parent => 'Содержимое сайта'

  before_filter :skip_sidebar!, :only => :index

  permit_params :title, :fact_ids => []

  config.sort_order = 'title_asc'

  # controller do
  #   cache_sweeper :suit_sweeper, :only => [:update,:create,:destroy]
  # end

  index do
    id_column
    column :title

    column :facts do |rubric|
      # нарисуем список
      list_items = ((rubric.facts.map { |p|
        "<li>• #{ p.title } <a href='/news/#{p.slug}' target='_blank'>[view]</a> <a href='/admin/facts/#{p.slug}/edit'>[edit]</a> </li>"
      }).join("")).html_safe

      "<ul>#{list_items}</ul>".html_safe
    end

    actions
  end

  form(:html => {:multipart => true}) do |f|
    f.inputs "Свойства" do
      f.input :title

      f.input :facts,
              :as => :check_boxes,
              :member_label => Proc.new { |p|
                p.title
              }

    end
    f.actions
  end

end