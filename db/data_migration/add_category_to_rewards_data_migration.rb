module DataMigrations
	CommitForbidden = Class.new(StandardError)
	class AddCategoryToRewardsDataMigration
		def self.call(commit_changes: false)
			ActiveRecord::Base.transaction do
			category=Category.first
			 Reward.includes(:categories).all.each do |r|
				next if r.categories.any?

				r.categories<<category
				r.save!
			  end
			  raise CommitForbidden unless commit_changes
			end
		end
	end
  end