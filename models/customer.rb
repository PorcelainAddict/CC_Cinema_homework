require_relative('../db/cinema_runner_sql.rb')

class Customer

  attr_accessor :id, :name, :funds

  def initialize(db_hash)
    @id = db_hash['id'].to_i if db_hash['id']
    @name = db_hash['name']
    @funds = db_hash['funds'].to_f
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING *"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)
    @id = customer.first['id'].to_i
  end

  def find()
    sql = "SELECT * FROM customers"
    values =[@name, @funds]
    customer = SqlRunner.run(sql, values)
    @id = customer.first['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    customers = customer_data.map{|geezer| Customer.new(geezer)}
    return customers
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.update_funds(values)
    sql = "UPDATE customers SET (funds) = ($1)"
    values = [amount]
  end

  def self.delete_all
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

  def films()
    sql = "SELECT *
    FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = films.map{|movie| Film.new(movie)}
    return result
  end


end
