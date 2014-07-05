module ApplicationHelper

  def bootstrap_flash(type)
    return {
      notice:  'alert-info',
      success: 'alert-success',
      warning: 'alert-warning',
      failure: 'alert-danger',
      error:   'alert-danger'
    }[type.to_sym] || type.to_s
  end
end
