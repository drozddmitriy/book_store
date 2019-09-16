class BookFiltersService
  class << self
    def filter(params)
      Book::FILTERS.include?(params&.to_sym) ? params.to_sym : Book::FILTERS.first
    end
  end
end
