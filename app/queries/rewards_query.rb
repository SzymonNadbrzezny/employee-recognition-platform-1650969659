class RewardsQuery
  attr_reader :initial_scope

  def initialize(params, is_using_pictures: false)
    @params = params
    initilize_collection(is_using_pictures: is_using_pictures)
  end

  def call
    filter_by_category(@params[:category])
  end

  private

  def initilize_collection(initial_scope = Reward.all, is_using_pictures:)
    @initial_scope = is_using_pictures ? initial_scope.with_attached_picture : initial_scope
  end

  def filter_by_category(filter = nil)
    if Category.all.exists?(title: filter)
      initial_scope.joins(:categories).where('categories.title': filter)
    else
      initial_scope
    end
  end
end
