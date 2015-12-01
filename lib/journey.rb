class Journey
  attr_reader :entry

  def initialized station
    @entry = station
    @exit = nil
  end
end
