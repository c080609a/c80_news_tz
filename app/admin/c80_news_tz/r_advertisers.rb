ActiveAdmin.register C80NewsTz::RAdvertiser, :as => 'RAdvertiser' do

  menu :label => "Рекламодатели", :parent => 'Содержимое сайта'

  before_filter :skip_sidebar!, :only => :index

  permit_params :title,
                :logo#,
                #:fact_ids => []

  config.sort_order = 'title_asc'

  # controller do
  #   cache_sweeper :suit_sweeper, :only => [:update,:create,:destroy]
  # end

  index do
    selectable_column
    id_column
    column :title
    column :logo do |a|
      if a.logo.present?
        "#{image_tag("#{a.logo.thumb_preview_big.url}")}".html_safe
      end
    end

=begin
    column :facts do |issue|
      # нарисуем список
      list_items = ((issue.facts.map { |p|
        "<li>• #{ p.title } <a href='/news/#{p.slug}' target='_blank'>[view]</a> <a href='/admin/facts/#{p.slug}/edit'>[edit]</a> </li>"
      }).join("")).html_safe

      "<ul>#{list_items}</ul>".html_safe
    end
=end

    actions
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs "Свойства" do

      f.input :title
      f.input :logo, :hint => "#{image_tag("#{f.object.logo.thumb_preview_big.url}")}".html_safe
    end

=begin
    f.inputs 'Публикации рекламодателя', :class => 'collapsed' do
      f.input :facts,
              :as => :check_boxes,
              :member_label => Proc.new { |p|
                "#{p.title} <a href='/news/#{p.slug}' target='_blank'>[view]</a> <a href='/admin/facts/#{p.slug}/edit'>[edit]</a>".html_safe
              }
    end
=end

    f.actions
  end

end