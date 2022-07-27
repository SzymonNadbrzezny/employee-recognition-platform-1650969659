class OrdersQuery
  attr_accessor :initial_scope

  def initialize(initial_scope = Orders.all)
    @initial_scope = initial_scope
  end

  def call(params)
    filter_by_status(initial_scope, params[:filter_by])
  end

  private

  def filter_by_status(scoped, filter = nil)
    filter ? scoped.where(status: filter) : scoped
  end
end
