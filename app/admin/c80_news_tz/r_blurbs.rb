ActiveAdmin.register C80NewsTz::RBlurb, :as => 'RBlurb' do

  #before_filter :skip_sidebar!, :only => :index

  menu :label => 'Публикации рекламодателей', :parent => 'Содержимое сайта'

  permit_params :short,
                :title,
                :leader_abz,
                :full,
                :r_bphotos_attributes => [:id, :image, :_destroy],
                :r_advertiser_ids => [],
                :rubric_ids => [],
                :issue_ids => []

  # controller do
  #   cache_sweeper :suit_sweeper, :only => [:update,:create,:destroy]
  # end

  index do
    selectable_column
    # id_column
    column :title
    column :created_at do |fact|
      local_time(fact[:created_at], format: '%e.%m.%Y')
    end

    column '' do |fact|
      if fact.r_bphotos.count > 0
        image_tag(fact.r_bphotos.first.image.thumb_preview_small)
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

      f.inputs 'Картинки, вставляемые в текст публикации (первая картинка идёт в предпросмотр публикации)', :class => 'collapsed' do
        f.has_many :r_bphotos, :allow_destroy => true do |p|
          p.input :image,
                       :as => :file,
                       :hint => image_tag(p.object.image.thumb_preview_medium)
        end
      end

      f.inputs 'Текст публикации' do
        f.input :full, :as => :ckeditor
      end


      f.inputs 'Рекламодатели, связанные с публикацией' do
        f.input :r_advertisers,
                :as => :check_boxes,
                :member_label => Proc.new { |p|
                  "#{p.title} <a href='/rcompanies/#{p.slug}' target='_blank'>[view]</a> <a href='/admin/r_advertisers/#{p.slug}/edit'>[edit]</a>".html_safe
                }
      end

    end
    f.actions
  end

end