ActiveAdmin.register C80NewsTz::Notice, :as => 'Notice' do

  menu :label => "Анонсы", :parent => 'Содержимое сайта'

  before_filter :skip_sidebar!, :only => :index

  permit_params :title,
                :place,
                :desc,
                :custom_org,
                :company_ids => [],
                :nphotos_attributes => [:id, :image, :_destroy],
                :adress_attributes => [:id, :locality, :street, :telephone_1, :telephone_2, :telephone_3, :latitude, :longitude, :email_1, :email_2, :site_1, :site_2],
                :gallery_attributes => [:id, :title, :gphotos_attributes => [:id, :image, :title, :_destroy]]

  config.sort_order = 'title_asc'

  # controller do
  #   cache_sweeper :suit_sweeper, :only => [:update,:create,:destroy]
  # end

  index do
    selectable_column
    id_column
    column :title
    column :place
    column :desc do |c|
      c.desc.html_safe[0..100]
    end

    column :companies do |notice|
      # нарисуем список
      list_items = ((notice.companies.map { |p|
        "<li>• #{ p.title } <a href='/companies/#{p.slug}' target='_blank'>[view]</a> <a href='/admin/companies/#{p.slug}/edit'>[edit]</a> </li>"
      }).join("")).html_safe
      li_custom = ''
      if notice.custom_org.present?
        li_custom = "<li>• #{ notice.custom_org }</li>"
      end
      "<ul>#{list_items}#{li_custom}</ul>".html_safe
    end


    actions
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs "Свойства" do

      f.input :title
      f.input :place

    end

    f.inputs "Адрес организатора", :class => 'collapsed', for: [:adress, f.object.adress || C80NewsTz::Adress.new] do |s|
      s.input :locality, :hint => 'Например: Калужская обл., г. Обнинск'
      s.input :street, :hint => 'Например: ул. Вавилова, д.1, офис 210'
      s.input :telephone_1, :hint => 'В любом формате'
      s.input :telephone_2
      s.input :telephone_3
      s.input :latitude, :hint => 'Широта (для Yandex.Карт)'
      s.input :longitude, :hint => 'Долгота (для Yandex.Карт)'
      s.input :email_1
      s.input :email_2
      s.input :site_1
      s.input :site_2
      s.actions
    end

    f.inputs 'Картинки, вставляемые в описание анонса', :class => 'collapsed' do
      f.has_many :nphotos, :allow_destroy => true do |nphoto|
        nphoto.input :image,
                     :as => :file,
                     :hint => image_tag(nphoto.object.image.thumb_preview)
      end
    end

    f.inputs "Описание анонса" do
      f.input :desc, :as => :ckeditor
    end

=begin

      f.has_many :pdfs, :allow_destroy => true do |ff|
        ff.input :file, :as => :file, :hint => ff.template.asset_url(ff.object.file)
      end
=end

    f.inputs 'Компании-организаторы', :class => 'collapsed' do
      f.input :companies,
              :as => :check_boxes,
              :member_label => Proc.new { |p|
                "#{p.title} <a href='/companies/#{p.slug}' target='_blank'>[view]</a> <a href='/admin/companies/#{p.slug}/edit'>[edit]</a>".html_safe
              }
      f.input :custom_org, :input_html => {:rows => 2, :class => 'code_area'}, :hint => 'Либо укажите организаторов в свободной форме, например: АО Вертикаль (г. Обнинск), НПО Тайфун (г. Москва)'
    end


    f.inputs 'Галерея анонса', :class => 'collapsed', for: [:gallery, f.object.gallery || C80NewsTz::Gallery.new] do |ff|
      #ff.input :title

      ff.has_many :gphotos, :allow_destroy => true do |gp|
        gp.input :image,
                 :as => :file,
                 :hint => gp.template.image_tag(gp.object.image.thumb_99)
        # gp.input :title#,
                 #:hint => 'Название фото. Будет выводиться при наведении мыши и при просмотре фото.'
      end
    end

    f.actions
  end

end