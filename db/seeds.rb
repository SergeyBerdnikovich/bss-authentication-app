# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_sergey = User.create( :login => "sergey", :password => "1234", :email => "sergey.berdnikovich@altoros.com")
user_sergey.role.create(:role => "Admin")

user_vasya = User.create( :login => "vasya", :password => "1234", :email => "vasya.pupkin@mail.ru")
user_vasya.role.create(:role => "User")

user_kolya = User.create( :login => "kolya", :password => "1234", :email => "kolya122@altoros.com")
user_kolya.role.create(:role => "User")

user_misha = User.create( :login => "misha11", :password => "1234", :email => "kakaha32@tut.by")
user_misha.role.create(:role => "User")
