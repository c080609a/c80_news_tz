ActiveAdmin.register C80NewsTz::Company, :as => 'Company' do

  menu :label => "Компании", :parent => 'Содержимое сайта'

  before_filter :skip_sidebar!, :only => :index

  permit_params :title,
                :activity_type,
                :desc,
                :logo,
                :fact_ids => [],
                :adress_attributes => [:id, :locality, :street, :telephone_1, :telephone_2, :telephone_3, :latitude, :longitude, :email_1, :email_2, :site_1, :site_2],
                :cphotos_attributes => [:id, :image, :_destroy],
                :galleries_attributes => [:id, :title, :gphotos_attributes => [:id, :image, :title, :_destroy]]

  config.sort_order = 'title_asc'

  # controller do
  #   cache_sweeper :suit_sweeper, :only => [:update,:create,:destroy]
  # end

  index do
    selectable_column
    id_column
    column :title
    column :activity_type
    column :desc do |c|
      c.desc.html_safe[0..100]
    end

=begin
    column '' do |company|
      if company.cphotos.count > 0
        image_tag(company.cphotos.first.image.thumb_preview)
      end
    end
=end

=begin

    column :pdfs do |issue|
      list_items = ((issue.pdfs.map { |pdf|
        "<li>• <a href='#{pdf.file.url}' target='_blank'>#{pdf.file}</a> </li>"
      }).join("").html_safe)
      "<ul>#{list_items}</ul>".html_safe
    end
=end

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

      f.input :title
      f.input :activity_type
      f.input :logo, :hint => "#{image_tag("#{f.object.logo.url}")}".html_safe
    end

    f.inputs "Адрес", :class => 'collapsed', for: [:adress, f.object.adress || C80NewsTz::Adress.new] do |s|
      s.input :locality
      s.input :street
      s.input :telephone_1
      s.input :telephone_2
      s.input :telephone_3
      s.input :latitude
      s.input :longitude
      s.input :email_1
      s.input :email_2
      s.input :site_1
      s.input :site_2
      s.actions
    end

    f.inputs 'Картинки, вставляемые в описание', :class => 'collapsed' do
      f.has_many :cphotos, :allow_destroy => true do |cphoto|
        cphoto.input :image,
                     :as => :file,
                     :hint => image_tag(cphoto.object.image.thumb_preview)
      end
    end

    f.inputs "Описание" do
      f.input :desc, :as => :ckeditor
    end

=begin

      f.has_many :pdfs, :allow_destroy => true do |ff|
        ff.input :file, :as => :file, :hint => ff.template.asset_url(ff.object.file)
      end
=end
    f.inputs 'Публикации, связанные с компанией', :class => 'collapsed' do
      f.input :facts,
              :as => :check_boxes,
              :member_label => Proc.new { |p|
                "#{p.title} <a href='/news/#{p.slug}' target='_blank'>[view]</a> <a href='/admin/facts/#{p.slug}/edit'>[edit]</a>".html_safe
              }
    end

    f.inputs "Галереи", :class => 'collapsed-with-bug' do

      f.has_many :galleries, :class => 'no-collapsed', :allow_destroy => true do |ff|
        ff.input :title
        # f.input :tag

        ff.has_many :gphotos, :allow_destroy => true do |gp|
          gp.input :image,
                   :as => :file,
                   :hint => gp.template.image_tag(gp.object.image.thumb_99)
          gp.input :title,
                   :hint => 'Название фото. Будет выводиться при наведении мыши и при просмотре фото.'
        end
      end

    end

    f.actions
  end

end