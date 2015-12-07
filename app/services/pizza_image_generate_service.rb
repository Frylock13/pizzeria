class PizzaImageGenerateService
  attr_accessor :pizza

  def initialize(pizza)
    @pizza = pizza
  end

  def generate
    MiniMagick::Tool::Convert.new do |convert|
      convert.resize '500x500'
      convert << 'app/assets/images/constructor/korg.png'
      convert << 'app/assets/images/constructor/kechu.png'
      convert << 'app/assets/images/constructor/kurica.png'
      convert << 'app/assets/images/constructor/sir2.png'
      convert.set 'page'
      convert << '+0+0'
      convert.background 'none'
      convert.layers 'merge'
      convert << '+repage'
      convert << 'tmp/output.png'
    end

    # korg = MiniMagick::Image.new 'app/assets/images/constructor/korg.png'
    # image = korg
    # image = image.composite MiniMagick::Image.new 'app/assets/images/constructor/kechu.png'
    # image = image.composite MiniMagick::Image.new 'app/assets/images/constructor/kurica.png'
    # image = image.composite MiniMagick::Image.new 'app/assets/images/constructor/sir2.png'
    # image = image.composite MiniMagick::Image.new 'app/assets/images/constructor/sir2.png'
    # image = image.composite MiniMagick::Image.new 'app/assets/images/constructor/sir2.png'
    # image = image.composite MiniMagick::Image.new 'app/assets/images/constructor/sir2.png'
    # image = image.composite MiniMagick::Image.new 'app/assets/images/constructor/sir2.png'
    # image = image.composite MiniMagick::Image.new 'app/assets/images/constructor/sir2.png'
    # image.write 'tmp/output.png'
    pizza.image = Rails.root.join('tmp/output.png').open
  end
end
