module NotificationsHelper
  def notification_form(notification)
    visited = notification.visited
    visiter = notification.visiter
    case notification.action
    when "chat" then
     "The user has sent you a message"
    when "follow" then
      "The user has followed you."
    when "like" then
      tag.a("The user liked") + tag.a(' your article', href: post_path(notification.post_id), style: "color:orange;")
    when "comment" then
    if notification.post.user_id == visited.id
      tag.a("The user has commented on") + tag.a(' your article', href: post_path(notification.post_id), style: "color:orange;") 
    else
      tag.a("The user has commented on") + tag.a(' your reply', href: post_path(notification.post_id), style: "color:orange;")  
    end
    end
  end
end