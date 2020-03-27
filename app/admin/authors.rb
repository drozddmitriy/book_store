ActiveAdmin.register Author do
  remove_filter :authors_books
  permit_params :first_name, :last_name, :biography

  index do
    selectable_column

    column :first_name
    column :last_name
    column :biography
    column :actions do |resource|
      links = []
      links << link_to(I18n.t('views.admin.edit'), edit_admin_author_path(resource))
      links << link_to(I18n.t('views.admin.delete'),
                       admin_author_path(resource),
                       method: :delete,
                       data: { confirm: I18n.t('views.admin.are_you_sure_authors', books_count: resource.books.count) })
      safe_join(links, ' ')
    end
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :biography
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :biography
      f.actions
    end
  end
end
