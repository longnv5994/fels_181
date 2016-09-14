module UsersHelper
  def gravatar_for user, size: Settings.avatar.size
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def check_activity action_type, target_id, user
    case action_type
    when Activity.activity_types[:follow]
      followed_user = User.find_by id: target_id
      user.name + t("follow") + (followed_user.nil? ?
        t("undefine_user") : followed_user.name)
    when Activity.activity_types[:unfollow]
      followed_user = User.find_by id: target_id
      user.name + t("unfollow") + (followed_user.nil? ?
        t("undefine_user") : followed_user.name)
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
