class KudoPolicy < ApplicationPolicy
  def create?
    can_afford?
  end

  def show?
    creator?
  end

  def update?
    creator? && created_less_than_5_minutes_ago?
  end

  def destroy?
    update?
  end

  def can_afford?
    @user.number_of_available_kudos.positive?
  end

  def created_less_than_5_minutes_ago?
    @record.created_at > 5.minutes.ago
  end

  def creator?
    @user == @record.giver
  end
end
