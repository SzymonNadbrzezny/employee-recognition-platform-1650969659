require 'rails_helper'

describe KudoPolicy do
  subject(:policy) { described_class.new(employee, kudo) }

  let!(:employee) { create(:employee, number_of_available_kudos: 1) }

  let!(:kudo) { create(:kudo, giver: employee, receiver: employee) }

  context 'when Employee has avaible kudos it allows to create, show, edit and destroy kudos' do
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context "when Employee doesn' have avaible kudos it allows
	to show, edit and destroy kudos but forbids from creating new ones" do
    let!(:employee) { create(:employee, number_of_available_kudos: 0) }

    it { is_expected.to forbid_action(:create) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'when Kudo was created less than 5 minutes ago' do
    Time.current
    it 'permits editing and destroying kudo' do
      Time.current
      travel 1.minute
      expect(policy).to permit_action(:update)
      expect(policy).to permit_action(:destroy)
    end
  end

  context 'when Kudo was created more than 5 minutes ago' do
    it 'forbids editing and destroying kudo' do
      Time.current
      travel 6.minutes
      expect(policy).to forbid_action(:update)
      expect(policy).to forbid_action(:destroy)
    end
  end
end
