module Admins
  class CategoryPolicy < ApplicationPolicy
    def destroy?
      without_rewards?
    end

    def without_rewards?
      @record.rewards.size.zero?
    end
  end
end
