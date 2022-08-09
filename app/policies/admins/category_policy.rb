module Admins
  class CategoryPolicy < ApplicationPolicy
    def destroy?
      not_assigned?
    end

    def not_assigned?
      @record.rewards.size.zero?
    end
  end
end
