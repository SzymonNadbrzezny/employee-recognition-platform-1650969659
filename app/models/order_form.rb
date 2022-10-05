class OrderForm
  include ActiveModel::Model

  attr_accessor :reward_id, :employee, :street, :postal_code, :city, :address_id

  def save
    reward = Reward.find(reward_id)
    address = nil
    ActiveRecord::Base.transaction do
      if reward.delivery_method == 'post'
        if address_id.present?
          address = Address.find(address_id)
          address.last_used = Time.current
          address.save!
        else
          address = Address.create!(employee: employee, street: street, city: city, postal_code: postal_code,
                                    last_used: Time.current)
        end
      end

      Order.create!(reward: reward, address_snapshot: address, buyer: employee)
    end
    true
  rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    false
  end
end
