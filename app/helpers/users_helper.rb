module UsersHelper
  def gravatar_for user, size: Settings.avatar.size
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def check_activity action_type, target_id, user
    case action_type
    when Activity.activity_types[:follow]
      user.name + t("follow") + User.find_by(id: target_id).name
    when Activity.activity_types[:unfollow]
      user.name + t("unfollow") + User.find_by(id: target_id).name
    when Activity.activity_types[:create_lesson]
      user.name + t("lesson.create_lesson")
    when Activity.activity_types[:finished]
      user.name + t("lesson.finished-lesson")
    when Activity.activity_types[:learn_lesson]
      user.name + t("lesson.learn_lesson")
    else
      t "none"
    end
  end
end
