module ApplicationHelper
  BOOTSTRAP_FLASH_CLASS_MAPPING = {
    'success' => 'alert-success',
    'error' => 'alert-danger',
    'alert' => 'alert-warning',
    'notice' => 'alert-info'
  }.freeze

  def flash_class_for(message_type)
    stringified_message_type = message_type.to_s
    BOOTSTRAP_FLASH_CLASS_MAPPING[stringified_message_type] || stringified_message_type
  end
end
