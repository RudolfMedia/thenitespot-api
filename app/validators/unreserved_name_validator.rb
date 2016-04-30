class UnreservedNameValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if !value || %w(eat drink attend nitespot thenitespot the-nitespot spot spots new-spot update-spot).include?(value.downcase)
      record.errors[attribute] << (options[:message] || "#{value} is reserved. ")
    end
  end

end