# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  phone: '1234567890',
  role: :admin
)

user = User.create!(
  name: 'Regular User',
  email: 'user@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  phone: '0987654321',
  role: :user
)


