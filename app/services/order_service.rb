class OrderService
  class << self
    def generate_number
      'R' + Array.new(10) { rand(1...10) }.join
    end
  end
end
