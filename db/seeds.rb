# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'admin@tma.org', password: 'password', name: 'Admin', is_admin: true, authentication_token: '2-pvxogfa5ah8jtoGb7D')
User.create(email: 'client@tma.org', password: 'password', name: 'Client', is_admin: false)
