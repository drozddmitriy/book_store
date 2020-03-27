class CouponService
  class << self
    def generate
      Array.new(10) { rand(1...10) }.join
    end
  end
end
