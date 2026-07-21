# ViewComponent 4.12 calls an Action View method removed on Rails main.
# Remove this compatibility alias once ViewComponent uses Template::Handlers.extensions.
unless ActionView::Template.respond_to?(:template_handler_extensions)
  ActionView::Template.define_singleton_method(:template_handler_extensions) do
    ActionView::Template::Handlers.extensions
  end
end
