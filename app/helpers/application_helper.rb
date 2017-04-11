module ApplicationHelper
  def message_type_class_name(type)
    types_name = HashWithIndifferentAccess.new(
      error: 'danger',
      notice: 'info',
      success: 'success'
    )

    types_name[type]
  end
end
