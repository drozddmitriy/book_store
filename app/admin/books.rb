# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Book do
  preserve_default_filters!
  remove_filter :authors_books, :order_items
  filter :authors, collection: -> { AuthorDecorator.decorate_collection(Author.all) }
  permit_params :title, :description, :price, :quantity,
                :year, :dimension_h, :dimension_w, :dimension_d,
                :material, :category_id, author_ids: [], images: []

  index do
    selectable_column

    column :title
    column :images do |resource|
      image_tag resource.images.first.thumb.url if resource.images.any?
    end
    column :category
    column :authors do |resource|
      BookDecorator.new(resource).author_full_name
    end
    column :description do |resource|
      truncate(resource.description, length: 250)
    end
    column :price do |resource|
      number_to_currency(resource.price, unit: I18n.t('currency'))
    end
    column :actions do |resource|
      links = []
      links << link_to(I18n.t('views.admin.view'), admin_book_path(resource))
      links << link_to(I18n.t('views.admin.edit'), edit_admin_book_path(resource))
      links << link_to(I18n.t('views.admin.delete'),
                       admin_book_path(resource),
                       method: :delete,
                       data: { confirm: I18n.t('views.admin.are_you_sure_books') })
      safe_join(links, ' ')
    end
  end

  show do
    panel 'Images' do
      table do
        resource.images.each do |image|
          span image_tag image.thumb.url
        end
      end
    end
    attributes_table do
      row :title
      row :authors do |resource|
        BookDecorator.new(resource).author_full_name
      end
      row :category
      row :year
      row :description
      row :material
      row :dimension_h
      row :dimension_w
      row :dimension_d
      row :price
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)

    f.inputs do
      f.input :title
      f.input :authors, as: :check_boxes, collection: AuthorDecorator.decorate_collection(Author.all)
      f.input :category, as: :radio
      f.input :description
      f.input :year
      f.input :price
      f.input :material
      f.input :dimension_h
      f.input :dimension_w
      f.input :dimension_d
      f.input :quantity
    end

    f.inputs do
      f.input :images, as: :file, input_html: { multiple: true }
    end

    f.inputs 'Images', multipart: true do
      f.object.images.each do |image|
        span image_tag image.thumb.url
      end
    end

    f.actions
  end

  action_item :delete_image, only: :edit do
    link_to(I18n.t('views.admin.delete_all_images'), delete_image_admin_book_path(resource), method: :delete)
  end

  member_action :delete_image, method: :delete do
    book = Book.find_by(id: resource.id)
    book.remove_images!
    book.save
    redirect_to edit_admin_book_path(book)
  end
end
# rubocop:enable Metrics/BlockLength
