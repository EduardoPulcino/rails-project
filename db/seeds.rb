# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  admin = User.create!(
    name: 'Admin User',
    email: 'admin@example.com',
    password: 'password123',
    password_confirmation: 'password123',
    phone: '12345678901',
    role: :admin
  )

  user = User.create!(
    name: 'Regular User',
    email: 'user@example.com',
    password: 'password123',
    password_confirmation: 'password123',
    phone: '09876543212',
    role: :user
  )
end

if Rails.env.production?
  unless User.find_by(email: ENV.fetch("ADMIN_EMAIL"))
    User.create!(
      name: "Simone",
      email: ENV.fetch("ADMIN_EMAIL"),
      password: ENV.fetch("ADMIN_PASSWORD"),
      password_confirmation: ENV.fetch("ADMIN_PASSWORD"),
      phone: ENV.fetch("ADMIN_PHONE"),
      role: :admin
    )
    puts "-> Admin criado com sucesso"
  else
    puts "-> Admin já existe"
  end
end


