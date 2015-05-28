class UnreservedNameValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if %w(eat drink attend nitespot thenitespot the-nitespot spot spots).include? value.downcase
      record.errors[attribute] << (options[:message] || "#{value} is reserved. ")
    end
  end

end