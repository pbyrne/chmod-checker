class ChmodParser
  attr_accessor :mode

  def initialize(mode)
    self.mode = mode
  end

  def chmod
    raise MissingMode unless mode.present?
    raise InvalidMode unless valid?

    Chmod.new
  end

  def valid?
    mode =~ /\A[0124]?[0-7]{3}\z/
  end

  MissingMode = Class.new(StandardError)
  InvalidMode = Class.new(StandardError)
end
