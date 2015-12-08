class PizzaImageGenerateService
  attr_accessor :pizza

  def initialize(pizza)
    @pizza = pizza
  end

  def generate
    MiniMagick::Tool::Convert.new do |convert|
      # convert.resize '1000x1000'
      convert << 'app/assets/images/dough.png'
      pizza.ingredients.order(:layer).each do |ingredient|
        convert << "public#{ingredient.image.url}" if ingredient.image.present?
      end
      convert << 'app/assets/images/dough_border.png' if pizza.dough_id == 2
      convert.set 'page'
      convert << '+0+0'
      convert.background 'none'
      convert.layers 'merge'
      convert << '+repage'
      convert << 'tmp/output.png'
    end
    pizza.image = Rails.root.join('tmp/output.png').open
  end
end
