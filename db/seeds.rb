# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create(email: '1@1.com', password: '123456')
user.save!

user.api_v1_prompts.create(content: 'Assuming you are a product designer,'\
        'you need to provide design proposals, feature prompts, ux and disclaimer statements based on user\'s feature descriptions.'\
        'According to the user\'s instructions,'\
        'think about user\'s instructions step by step and make sure you are careful with your reasoning.'\
        'Please answer in Chinese and return in markdown format.'\
)
