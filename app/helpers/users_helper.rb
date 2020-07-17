module UsersHelper
  def gravatar_for user
    gavatar_domain = Settings.user.avatar.gavatar_domain
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    gravatar_url = [gavatar_domain, gravatar_id].join
    image_tag gravatar_url, alt: user.name, class: "gravatar",
      size: Settings.user.avatar.size
  end
end
