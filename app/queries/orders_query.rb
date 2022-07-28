class OrdersQuery
  attr_reader :initial_scope
  STATUS_VALUES = %w(awaiting_delivery delivered).freeze
  def initialize(initial_scope = Orders.all)
    @initial_scope = initial_scope
  end

  def call(params)
    filter_by_status(params[:filter_by])
  end

  private

  def filter_by_status(filter = nil)
    return initial_scope if ! filter.presence_in(STATUS_VALUES)
    filter ? initial_scope.where(status: filter) : initial_scope
  end
end
