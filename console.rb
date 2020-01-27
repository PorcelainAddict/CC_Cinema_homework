require('pry-byebug')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


customer1 = Customer.new({'name' => 'Smartin', 'funds' => 10.50})
customer1.save()
customer2 = Customer.new({'name' => 'Elsebeth', 'funds' => 77.58})
customer2.save()

customer1.funds = 100.73
customer1.name = "Tim"
customer1.update()

film1 = Film.new({'title' => 'Samsara', 'price' => 5.00})
film1.save
film2 = Film.new({'title' => 'Hackers', 'price' => 6.50})
film2.save
film3 = Film.new({'title' => 'Kon Tiki', 'price' => 2.50})
film3.save

film1.price = 10.00
film1.update()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save
ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film3.id})
ticket3.save
ticket4 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id})
ticket4.save
ticket5 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket5.save



binding.pry
nil
