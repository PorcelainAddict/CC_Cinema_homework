require_relative('../db/cinema_runner_sql.rb')



class Film

  attr_accessor :id, :title, :price

  def initialize(db_hash)
    @id = db_hash['id'].to_i if db_hash['id']
    @title = db_hash['title']
    @price = db_hash['price'].to_f

  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING *"
    values = [@title,@price]
    films = SqlRunner.run(sql, values)
    @id = films.first['id'].to_i
  end

  def find()
    sql = "SELECT * FROM films"
    values =[@title, @price]
    film = SqlRunner.run(sql, values)
    @id = film.first['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    film_data = SqlRunner.run(sql)
    films = film_data.map{|movie| Film.new(movie)}
    return films
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT *
    FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE tickets.film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    result = customers.map{|punter| Customer.new(punter)}
    return result
  end




end
