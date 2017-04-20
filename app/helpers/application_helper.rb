module ApplicationHelper
  def message_type_class_name(type)
    types_name = HashWithIndifferentAccess.new(
      error: 'danger',
      notice: 'info',
      success: 'success'
    )

    types_name[type]
  end

  def business_address(business)
    business.street + ', ' + business.city + ', ' + business.state + ' ' + business.zipcode
  end

  def phone_number(phone)
    phone_string = phone.to_s
    "(#{phone_string.slice(0..2)}) #{phone_string.slice(3..5)}-#{phone_string.slice(6..9)}"
  end

  def format_date(date)
    date.strftime('%m/%d/%Y')
  end

  def rating_options
    [['1 Star', 1], ['2 Stars', 2], ['3 Stars', 3], ['4 Stars', 4], ['5 Stars', 5]]
  end
end
