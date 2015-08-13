require './app/models/user.rb'

feature 'User sign up' do
  # the tests that check the UI
  # (have_content, etc.) should be separate from the tests
  # that check what we have in the DB since these are separate concerns
  # and we should only test one concern at a time.
  # However, we are currently driving everything through
  # feature tests and we want to keep this example simple.

  scenario 'I can sign up as new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'with a password that does not match' do
    # again it's questionable whether we should be testing the model at this
    # level.  We are mixing integration tests with feature tests.
    # However, it's convenient for our purposes.
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'without an email' do
    visit '/users/new'
    fill_in :password, with: '123456'
    fill_in :password_confirmation, with: '123456'
    click_button 'Sign up'
    expect(User.count).to eq 0
    expect(current_path).to eq '/users/new'
  end

end

def sign_up(email: 'alice@example.com', password: '12345678',  password_confirmation: '12345678') # <--helper method!
  visit '/users/new'
  fill_in :email, with: email
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end
