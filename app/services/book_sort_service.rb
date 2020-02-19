class BookSortService
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

  def sort_sym
    SORTS.key?(params&.to_sym) ? params.to_sym : SORTS.keys.first
  end

  def sort_string
    (SORTS.key?(params&.to_sym) ? SORTS[params.to_sym] : SORTS[:newest]).call
  end
end
