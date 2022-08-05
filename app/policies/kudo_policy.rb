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
    creator? && created_less_than_5_minutes_ago?
  end

  def can_afford?
    @user.number_of_available_kudos.positive?
  end

  def created_less_than_5_minutes_ago?
    @record.created_at > five_minutes_ago
  end

  def creator?
    @user == @record.giver
  end

  def five_minutes_ago
    5.minutes.ago
  end
end
