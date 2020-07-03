# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Admin.create! :email => 'brianberg@romainberg.com', :password => 'dl6cd1357', :password_confirmation => 'dl6cd1357'
admin = Admin.create! :email => 'samromain@romainberg.com', :password => 'dl6cd1357', :password_confirmation => 'dl6cd1357'
admin = Admin.create! :email => 'jony.malhotra82@gmail.com', :password => 'dl6cd1357', :password_confirmation => 'dl6cd1357'
