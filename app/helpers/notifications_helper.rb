module NotificationsHelper
  def notification_form(notification)
    visiter = notification.visiter
    visited = notification.visited
    case notification.action
    when "follow" then
      tag.a(notification.visiter.name, href: user_path(visiter), style: "font-weight: bold;") + "があなたのことをフォローしました"
    when "like" then
      tag.a(notification.visiter.name, href: user_path(visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id), style: "font-weight: bold;") + "にいいねしました"
    when "comment" then
    if notification.post.user_id == visited.id
      tag.a(visiter.name, href: user_path(visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id), style: "font-weight: bold;") + "にコメントしました"
    else
      tag.a(visiter.name, href: user_path(visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの返信', href: post_path(notification.post_id), style: "font-weight: bold;") + "にコメントしました"
    end
    end
  end
end