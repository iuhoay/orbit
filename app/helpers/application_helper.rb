module ApplicationHelper
  def form_errors_for(form)
    render("shared/form_errors", form: form) if form.object.errors.any?
  end
end
