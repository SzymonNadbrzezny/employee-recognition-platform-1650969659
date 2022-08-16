class RewardsQuery
  attr_reader :initial_scope

  def initialize(initial_scope = Reward.all)
    @initial_scope = initial_scope
  end

  def call(params)
    filter_by_category(params[:category])
  end

  private

  def filter_by_category(filter = nil)
    if Category.all.exists?(title: filter)
      initial_scope.joins(:categories).where('categories.title': filter)
    else
      initial_scope
    end
  end
end
