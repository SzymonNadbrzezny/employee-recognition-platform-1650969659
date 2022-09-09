class ApplicationService
  attr_reader :result

  def initialize
    raise 'Implement initilization'
  end

  def self.call(...)
    new(...).call
  end

  def success?
    result[:success?]
  end

  def value!(value)
    result[:value!][value]
  end

  def failure
    result[:failure]
  end
end
