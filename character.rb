class Character
  attr_accessor :name_field, :nodes
  
  def initialize
    nodes = []
  end

  def name
    self.name_field.text()
  end

  def name=(text)
    self.name_field = text
  end

end
