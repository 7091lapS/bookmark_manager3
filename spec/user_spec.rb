require './app/data_mapper_setup'

describe User do

  let!(:user) do
    User.create(email: 'test@test.com', password: 'secret', password_confirmation: 'secret' )
  end

  it 'authenticates when given a valid email address and password' do
    authenticated_user = User.authenticate(user.email, user.password)
    expect(authenticated_user).to eq user
  end

  it 'does not authenticate with incorrect password' do
    expect(User.authenticate(user.email, 'wron_stupid_password')).to be_nil
  end

end
