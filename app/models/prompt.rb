class Prompt < ApplicationRecord
  has_many :user_prompt_ships
  has_many :users, through: :user_prompt_ships
end
