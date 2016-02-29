ActiveAdmin.register C80NewsTz::Fact, :as => 'Fact' do

  before_filter :skip_sidebar!, :only => :index

  menu :label => 'Новости', :parent => 'Содержимое сайта'

  permit_params :short,
                :title,
                :leader_abz,
                :full,
                # :keywords,
                # :description,
                :fphotos_attributes => [:id, :image, :_destroy],
                :company_ids => [],
                :rubric_ids => [],
                :issue_ids => []

  # controller do
  #   cache_sweeper :suit_sweeper, :only => [:update,:create,:destroy]
  # end

  index do
    selectable_column
    id_column
    column :title
    column :created_at do |fact|
      local_time(fact[:created_at], format: '%e.%m.%Y')
    end

    column '' do |fact|
      if fact.fphotos.count > 0
        image_tag(fact.fphotos.first.image.thumb_preview)
      end
    end

    column :short
    column :rubrics do |fact|
      # нарисуем список
      list_items = ((fact.rubrics.map { |p|
        "<li>#{ p.title }</li>"
      }).join("")).html_safe

      "<ul>#{list_items}</ul>".html_safe
    end
    column :issue do |fact|
      # нарисуем список
      list_items = ((fact.issues.map { |p|
        "<li>• #{ p.number } <a href='/issues/#{p.id}' target='_blank'>[view]</a> <a href='/admin/issues/#{p.id}/edit'>[edit]</a> </li>"
      }).join("")).html_safe

      "<ul>#{list_items}</ul>".html_safe
    end
    # column :full

    actions
  end

  form(:html => {:multipart => true}) do |f|
    f.inputs 'Свойства' do
      f.input :title

      f.input :rubrics,
              :as => :check_boxes,
              :member_label => Proc.new { |p|
                p.title
              }

      f.input :issues,
              :as => :check_boxes,
              :member_label => Proc.new { |p|
                p.number
              }

      f.input :short, :input_html => {:rows => 3, :class => 'code_area'}
      f.input :leader_abz, :input_html => {:rows => 3, :class => 'code_area'}

      f.inputs 'Картинки, вставляемые в текст новости (первая картинка идёт в предпросмотр новости)', :class => 'collapsed' do
        f.has_many :fphotos, :allow_destroy => true do |fphotos|
          fphotos.input :image,
                       :as => :file,
                       :hint => image_tag(fphotos.object.image.thumb_preview)
        end
      end

      f.inputs 'Текст новости' do
        f.input :full, :as => :ckeditor
      end


      f.inputs 'Компании, связанные с публикацией' do
        f.input :companies,
                :as => :check_boxes,
                :member_label => Proc.new { |p|
                  "#{p.title} <a href='/companies/#{p.slug}' target='_blank'>[view]</a> <a href='/admin/companies/#{p.slug}/edit'>[edit]</a>".html_safe
                }
      end

      # f.input :keywords,
      #         :input_html => {
      #             :class => 'code_area',
      #             :rows => 2
      #         }#,
      # :hint => "[SEO] meta Keywords; Поле можно оставить пустым, тогда будут использованы ключевые слова сайта:<br> #{SiteProps.first.keywords}".html_safe
      #f.input :description, :hint => "[SEO] meta Description; Поле можно оставить пустым, тогда будут использованы 200 первых символов новости."

    end
    f.actions
  end

end