module Pages
  class Login
    include Capybara::DSL
    include Rails.application.routes.url_helpers

    def visit_page
      visit login_path
    end

    def fill_and_submit(email:, password:)
      within 'form' do
        fill_in 'Username', with: email
        fill_in 'Password', with: password
        click_on 'Login'
      end
    end

    def has_success_message?
      within_notice do
        page.has_content? 'Success'
      end
    end

    def has_invalid_credentials_message?
      within_notice do
        page.has_content? 'Invalid credentials'
      end
    end

    def has_locked_out_message?
      within_notice do
        page.has_content? 'Account locked out. Please try again later.'
      end
    end

    private

    def within_notice
      within '.flash' do
        yield
      end
    end
  end
end
