class UserByEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless User.find_by(email: value)
      record.errors[attribute] << (options[:message] || 'пользователя с такой почтой не существует')
    end
  end
end
