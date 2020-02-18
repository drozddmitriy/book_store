class BookSortService
  MENU_SORTS = %i[newest popular_first title_asc title_desc price_asc price_desc].freeze

  SORTS = {
    newest: -> { I18n.t('models.book.newest') },
    pop_first: -> { I18n.t('models.book.pop_first') },
    title_asc: -> { I18n.t('models.book.title_asc') },
    title_desc: -> { I18n.t('models.book.title_asc') },
    price_asc: -> { I18n.t('models.book.price_asc') },
    price_desc: -> { I18n.t('models.book.price_desc') }
  }.freeze

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def filter_sym
    MENU_SORTS.include?(params&.to_sym) ? params.to_sym : MENU_SORTS.first
  end

  def filter_string
    (SORTS.include?(params&.to_sym) ? SORTS[params.to_sym] : SORTS[:newest]).call
  end
end
