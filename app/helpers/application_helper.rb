module ApplicationHelper
  def form_errors_for(form)
    render("shared/form_errors", form: form) if form.object.errors.any?
  end

  def active_link_to(name, path, options = {})
    options[:class] = "active" if current_page?(path)
    link_to(name, path, options)
  end

  # <details open>
  #   <summary>Parent</summary>
  #   <ul>
  #     <li><a>Submenu 1</a></li>
  #     <li><a>Submenu 2</a></li>
  #     <li>
  #       <details open>
  #         <summary>Parent</summary>
  #         <ul>
  #           <li><a>Submenu 1</a></li>
  #           <li><a>Submenu 2</a></li>
  #         </ul>
  #       </details>
  #     </li>
  #   </ul>
  # </details>
  def nested_list(item)
    children = item[:children]
    all_children = children.flat_map { |child| child[:children].present? ? child[:children] : child }
    content_tag(:details, open: all_children.any? { |child| current_page?(child[:path]) }) do
      safe_join [
        content_tag(:summary, item[:name]),
        content_tag(:ul) do
          children.map do |child|
            content_tag(:li) do
              if child[:children].present?
                nested_list(child)
              else
                active_link_to(child[:name], child[:path])
              end
            end
          end.join.html_safe
        end
      ]
    end
  end
end
