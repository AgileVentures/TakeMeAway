class FormtasticAttachinaryInput
  include Formtastic::Inputs::Base
  attr_reader :attachinary_options

  def to_html
    input_wrapping do
      label_html <<
      template.builder_attachinary_file_field_tag(method, @builder, { html: input_html_options })
    end
  end
end
