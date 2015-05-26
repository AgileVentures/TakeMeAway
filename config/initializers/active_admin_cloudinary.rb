require './app/inputs/formtastic_attachinary_input.rb'

module ActiveAdmin
  module Views
    module Pages
      class Base < Arbre::HTML::Document

        alias_method :original_build_head, :build_active_admin_head

        def build_active_admin_head
          original_build_head

          within @head do
            text_node cloudinary_js_config
          end
        end

      end
    end
  end
end
