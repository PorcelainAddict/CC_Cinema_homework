require_relative('../db/cinema_runner_sql.rb')


class Ticket

  attr_accessor :id, :customer_id, :film_id


  def initialize(db_hash)
    @id = db_hash['id'].to_i if db_hash['id']
    @customer_id = db_hash['customer_id'].to_i
    @film_id = db_hash['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING *"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values)
    @id = ticket.first['id'].to_i
  end

  def find()
    sql = "SELECT * FROM tickets"
    values = [@customer_id, @film_id]
    receipt = SqlRunner.run(sql, values)
    @id = receipt.first['id'].to_i
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    ticket_data = SqlRunner.run(sql)
    receipt = ticket_data.map{|receipt| Ticket.new(receipt)}
    return receipt
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end


end
