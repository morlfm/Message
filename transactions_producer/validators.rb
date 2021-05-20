require 'cpf_cnpj'

class Validator
  def validate_cpf(cpf)
    valid = CPF.valid?(cpf, strict: true)

    raise 'CPF invalid' unless valid
  end

  def validate_value(value)
    valid = value.is_a? Float

    raise 'Invalid value' unless valid
  end

  def validate_name(name)
    valid = name.is_a? String
    raise 'Please insert your name' unless valid
  end
end
