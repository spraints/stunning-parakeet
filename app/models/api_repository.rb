class ApiRepository
  def initialize(resource)
    @resource = resource
  end

  def full_name
    @resource.full_name
  end

  def hooked?
    [0,1].shuffle.first == 0
  end

  def to_param
    @resource.id.to_s
  end
end
