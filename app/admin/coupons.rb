ActiveAdmin.register Coupon do
  preserve_default_filters!
  remove_filter :order
  permit_params :coupon, :active, :sale

  form do |f|
    f.inputs do
      f.input :coupon, input_html: { value: CouponService.generate }
      f.input :active, input_html: { checked: true }
      f.input :sale, label: I18n.t('views.admin.sale')
    end
    f.actions
  end
end
