class User_transaction
  attr_accessor :cpf , :name , :value


 def self.from_json(json)
   User_transaction.new.tap do |transaction|
     unless json.nil?
       transaction.cpf = json['cpf']
       transaction.name = json['name']
       transaction.value = json['value']
      end
    end
  end
end
