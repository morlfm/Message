require 'mysql2'
require 'pry-byebug'

def self.deposit(value,cpf,name)

  begin
      # Initialize connection variables.

      # password = String('root')

      # byebug
      # Initialize connection object.
      client = Mysql2::Client.new(
  host: '127.0.0.1',
  port: 3306,
  database: 'test',
  username: 'root'
  # password: 'root',
  # reconnect: true
)
      puts 'Successfully created connection to database.'


      # client.query('CREATE TABLE balance (id INT(11) UNSIGNED  PRIMARY KEY, name VARCHAR(50), value DOUBLE);')
      # puts 'Finished creating table.'


      resultSet = client.query('SELECT * from balance;')
         resultSet.each do |row|

             puts 'Data row = (%s, %s, %s)' % [row['id'], row['name'], row['value']]
         end
         puts 'Read ' + resultSet.count.to_s + ' row(s).'

        


      client.query("INSERT INTO balance VALUES(#{cpf.to_i},'#{name.to_s}',#{value.to_f})")
      puts 'Inserted 1 rows of data.'

  # Error handling
  rescue Exception => e
      puts e.message

  # Cleanup
  ensure
      client.close if client
      puts 'Done.'
  end

end
