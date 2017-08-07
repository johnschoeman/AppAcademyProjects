class Card
  attr_accessor :face_value, :face_up

  def initialize(face_value)
    @face_value = face_value
    @face_up = false
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def to_s
    @face_up ? @face_value : "-"
  end

  def ==(card)
    @face_value == card.face_value
  end
end
