ActiveAdmin.register Review do
  includes :book, :user
  preserve_default_filters!
  filter :user, collection: -> { User.all.map(&:email) }
  permit_params :rating, :comment, :title

  config.remove_action_item(:new)
  actions :all, only: %i[index show]

  scope :all
  scope :published
  scope :unpublished

  action_item :publish, only: :show do
    link_to I18n.t('views.admin.publish'), publish_admin_review_path(review), method: :put unless review.publish?
  end

  action_item :publish, only: :show do
    link_to I18n.t('views.admin.unpublish'), unpublish_admin_review_path(review), method: :put if review.publish?
  end

  member_action :publish, method: :put do
    review = Review.find_by(id: params[:id])
    review.update(publish: true)
    redirect_to admin_review_path(review)
  end

  member_action :unpublish, method: :put do
    review = Review.find_by(id: params[:id])
    review.update(publish: false)
    redirect_to admin_review_path(review)
  end

  index do
    column :book
    column :user
    column :publish
    column :title
    column :rating
    column :comment
    column :created_at
    column :actions do |resource|
      links = []
      links << link_to(I18n.t('views.admin.show'), admin_review_path(resource))
      safe_join(links, ' ')
    end
  end
end
