feature 'User sign out' do

  scenario 'while being signed in' do
    user = create :user
    sign_in(user)
    click_button 'Sign out'
    expect(page).to have_content('goodbye!') # where does this message go?
    expect(page).not_to have_content('Welcome, #{user.email}')
  end
end
