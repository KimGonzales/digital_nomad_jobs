module Validate

  def self.valid?(input)
    input.between?(1, self.all.size)
  end 

end 