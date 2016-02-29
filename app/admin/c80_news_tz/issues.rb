ActiveAdmin.register C80NewsTz::Issue, :as => 'Issue' do

  menu :label => "Номера", :parent => 'Содержимое сайта'

  before_filter :skip_sidebar!, :only => :index

  permit_params :number,
                :fact_ids => [],
                :pdfs_attributes => [:id,:file,:_destroy]

  config.sort_order = 'number_asc'

  # controller do
  #   cache_sweeper :suit_sweeper, :only => [:update,:create,:destroy]
  # end

  index do
    selectable_column
    id_column
    column :number

    column :pdfs do |issue|
      list_items = ((issue.pdfs.map { |pdf|
        "<li>• <a href='#{pdf.file.url}' target='_blank'>#{pdf.file}</a> </li>"
      }).join("").html_safe)
      "<ul>#{list_items}</ul>".html_safe
    end

    column :facts do |issue|
      # нарисуем список
      list_items = ((issue.facts.map { |p|
        "<li>• #{ p.title } <a href='/news/#{p.slug}' target='_blank'>[view]</a> <a href='/admin/facts/#{p.slug}/edit'>[edit]</a> </li>"
      }).join("")).html_safe

      "<ul>#{list_items}</ul>".html_safe
    end

    actions
  end

  form(:html => {:multipart => true}) do |f|
    f.inputs "Свойства" do

      f.input :number

      f.has_many :pdfs, :allow_destroy => true do |ff|
        ff.input :file, :as => :file, :hint => ff.template.asset_url(ff.object.file)
      end

      f.input :facts,
              :as => :check_boxes,
              :member_label => Proc.new { |p|
                p.title
              }

    end
    f.actions
  end

end