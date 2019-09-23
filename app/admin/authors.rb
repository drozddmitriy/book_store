ActiveAdmin.register Author do
  permit_params :firstname, :lastname, :biography

  index do
    selectable_column

    column :firstname
    column :lastname
    column :biography
    column :actions do |resource|
      links = []
      links << link_to('Edit', edit_admin_author_path(resource))
      links << link_to('Delete', admin_author_path(resource), method: :delete, data: { confirm: "Are you sure you want to delete this items?
They are associated with #{resource.books.count} of books." })
      links.join(' ').html_safe
    end
  end

  show do
    attributes_table do
      row :firstname
      row :lastname
      row :biography
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :firstname
      f.input :lastname
      f.input :biography
      f.actions
    end
  end
end
