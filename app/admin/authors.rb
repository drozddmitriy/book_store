ActiveAdmin.register Author do
  remove_filter :authors_books
  permit_params :firstname, :lastname, :biography

  index do
    selectable_column

    column :firstname
    column :lastname
    column :biography
    column :actions do |resource|
      links = []
      links << link_to(I18n.t('views.admin.edit'), edit_admin_author_path(resource))
      links << link_to(I18n.t('views.admin.delete'), admin_author_path(resource), method: :delete, data: { confirm: I18n.t('views.admin.are_you_sure_authors', books_count: resource.books.count) })
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
