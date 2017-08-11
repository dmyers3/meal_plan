shared_examples "requires sign in" do
  it "redirects to the root page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to root_path
  end
end

shared_examples "requires signed out" do
  it "redirects to the home page" do
    dan = Fabricate(:user)
    session[:user_id] = dan.id
    action
    expect(response).to redirect_to home_path
  end
end

shared_examples "requires correct user" do
  it "redirects to the root page" do
    dan = Fabricate(:user)
    session[:user_id] = dan.id
    action
    expect(response).to redirect_to root_path
  end
end

shared_examples "requires admin" do
  it "redirects to the root page" do
    dan = Fabricate(:user)
    session[:user_id] = dan.id
    action
    expect(response).to redirect_to root_path
  end
end
