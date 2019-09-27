ActiveAdmin.register Book do
  preserve_default_filters!
  remove_filter :authors_books
  filter :authors, collection: -> { Author.all.map { |author| author.firstname + " #{author.lastname}" } }
  permit_params :title, :description, :price, :quantity, :year, :dimension_h, :dimension_w, :dimension_d, :material, :category_id, author_ids: []

  index do
    selectable_column

    column :title
    column :category
    column :authors do |resource|
      BookDecorator.new(resource).author_full_name
    end
    column :description do |resource|
      truncate(resource.description, length: 250)
    end
    column :price do |resource|
      number_to_currency(resource.price, unit: "€")
    end
    column :actions do |resource|
      links = []
      links << link_to('Edit', edit_admin_book_path(resource))
      links << link_to('Delete', admin_book_path(resource), method: :delete, data: { confirm: 'Are you sure you want to delete this items?' })
      links.join(' ').html_safe
    end
  end

  show do
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
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :title
      f.input :authors, as: :check_boxes, collection: Author.all.map { |author| [author.firstname + ' ' + author.lastname, author.id] }
      f.input :category, as: :radio
      f.input :description
      f.input :year
      f.input :price
      f.input :material
      f.input :dimension_h
      f.input :dimension_w
      f.input :dimension_d
      f.input :quantity
      f.actions
    end
  end
end
