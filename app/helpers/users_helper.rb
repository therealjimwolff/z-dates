module UsersHelper
  def gravatar_for(user, size: 250, classes: 'img-raised')
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name,
                            class: "img-circle img-responsive #{classes}",
                            id: 'profile-image')
  end
end
