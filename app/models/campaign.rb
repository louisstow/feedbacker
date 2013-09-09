class Campaign < ActiveRecord::Base
	belongs_to :user # owner id

	# many to many with requests
	has_many :requests
	has_many :users, through: :requests

	# many to many with requests
	has_many :campaign_categorizations
	has_many :categories, through: :campaign_categorizations

	has_many :feedbacks

	validates :title, presence: true, length: { minimum: 5 }
	validates :body, presence: true, length: { minimum: 150 }
	validates :list_type, presence: true

	validates :confirm_deadline_days, 
		presence: true, 
		numericality: { only_integer: true, greater_than: 0 }, 
		if: :is_private?

	validates :feedback_deadline_days, 
		presence: true, 
		numericality: { only_integer: true, greater_than: 0 }, 
		if: :is_private?

	validate :deadline_correctness

	def confirm_deadline_days
		@confirm_deadline_days
	end

	def feedback_deadline_days
		@feedback_deadline_days
	end

	def list_type
		if is_public == false
			'private'
		else
			'public'
		end
	end

	def is_private?
		!is_public
	end

	def deadline_correctness
		if self.confirm_deadline_days.to_i >= self.feedback_deadline_days.to_i
			self.errors.add :base, "Confirm deadline must be before feedback deadline"
		end
	end
	
	def list_type=(value)
		self.is_public = value == 'public'
	end

	def confirm_deadline_days=(days)
		t = Time.now + days.to_i.days
		self.confirm_deadline = t
		@confirm_deadline_days = days
	end

	def feedback_deadline_days=(days)
		t = Time.now + days.to_i.days
		self.feedback_deadline = t
		@feedback_deadline_days = days
	end	
end
