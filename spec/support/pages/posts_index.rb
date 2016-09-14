module Pages
  class PostsIndex
    include Capybara::DSL
    include CapybaraErrorIntel::DSL

    def on_page?
      has_selector?('h1', text: 'Posts')
    end
  end
end

