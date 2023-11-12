class AchieveQuestion < ApplicationRecord
  belongs_to :user
  has_many :achieve_answers
end
