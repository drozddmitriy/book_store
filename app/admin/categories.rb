ActiveAdmin.register Category do
  permit_params :title

  index do
    selectable_column

    column :title
    column :actions do |resource|
      links = []
      links << link_to('Edit', edit_admin_category_path(resource))
      links << link_to('Delete', admin_category_path(resource), method: :delete, data: { confirm: "Are you sure you want to delete these item?
  They are associated with #{resource.books.count} of books." })
      links.join(' ').html_safe
    end
  end

  show do
    attributes_table do
      row :title
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :title
      f.actions
    end
  end
end
