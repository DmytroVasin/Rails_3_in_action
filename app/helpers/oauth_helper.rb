module OauthHelper
  def auth_provider(name)
    link_to "Sign in with #{name}",
    # .humanize,
    user_omniauth_authorize_path(name),
    :id => "sign_in_with_#{name}"
  end
end
