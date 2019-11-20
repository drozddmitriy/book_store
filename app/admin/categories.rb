ActiveAdmin.register Category do
  permit_params :title

  index do
    selectable_column

    column :title
    column :actions do |resource|
      links = []
      links << link_to(I18n.t('views.admin.edit'), edit_admin_category_path(resource))
      links << link_to(I18n.t('views.admin.delete'),
                       admin_category_path(resource),
                       method: :delete,
                       data: { confirm: I18n.t('views.admin.are_you_sure_categorie',
                                               books_count: resource.books.count) })
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
