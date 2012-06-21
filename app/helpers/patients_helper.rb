module PatientsHelper

  # Returns the Gravatar(image_tag) (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = {size: 50})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    image_tag(gravatar_url, alt: user.first_name + ' ' + user.last_name, 
    	class: "gravatar")
  end

  def display_name_with_ref_for(user)
    content_tag(:span, user.reference_number,
       :class => "badge badge-inverse") + " " + display_name_for(user)
  
  end


  def display_name_for(user)
    user.first_name.capitalize + ' ' + user.last_name.capitalize
  end

end
