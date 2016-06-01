module InputHelper
  def create_select(name, options, selected = nil)
    input_string = "<select name=\"#{name}\" id=\"#{name}\">"

    options.each do |option|
      input_string << "<option value=\"#{option}\""
      input_string << "#{selected?(selected, option)}>"
      input_string << "#{option}</option>"
    end
    input_string << "</select>"

    input_string
  end

  private

  def selected?(current_value, option_value)
    " selected" if current_value == option_value
  end
end
