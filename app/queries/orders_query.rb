class OrdersQuery
  attr_reader :initial_scope

  def initialize(initial_scope = Orders.all)
    @initial_scope = initial_scope
  end

  def call(params)
    filter_by_status(params[:filter_by])
  end

  private

  def filter_by_status(filter = nil)
    Order.statuses.include?(filter) ? initial_scope.where(status: filter) : initial_scope
  end
end
