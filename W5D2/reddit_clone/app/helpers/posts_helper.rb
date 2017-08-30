module PostsHelper

  def list_comments(comment)
    #base case
    if comment.child_comments.empty?
      html = "<p>"
      html += "<a href=#{comment_url(comment)}>#{h(comment.content)}</a>"
      html += "</p>"
      return html.html_safe
    end

    #iterative step
    html = "<p>"
    html += "<a href=#{comment_url(comment)}>#{h(comment.content)}</a>"
    html += "</p>"

    html += "<ul>"
    comment.child_comments.each do |child|
      html += "<li>"
      html += list_comments(child)
      html += "</li>"
    end
    html += "</ul>"
    return html.html_safe
  end

  def better_list_comments(all_comments, comment)
    #base case
    if all_comments.none? { |child| child.parent_comment_id == comment.id}
      html = "<p>"
      html += "<a href=#{comment_url(comment)}>#{h(comment.content)}</a>"
      html += "</p>"
      return html.html_safe
    end

    #iterative step

    html = "<p>"
    html += "<a href=#{comment_url(comment)}>#{h(comment.content)}</a>"
    html += "</p>"

    html += "<ul>"
    all_comments.each do |child|
      next unless child.parent_comment_id == comment.id
      html += "<li>"
      html += better_list_comments(all_comments, child)
      html += "</li>"
    end
    html += "</ul>"
    return html.html_safe
  end


  def best_list_comments(all_hash_comments, comment)
    html = "#{count_votes(comment)}"
    html += "<p>"
    html += "<a href=#{comment_url(comment)}>#{h(comment.content)}</a>"
    html += "</p>"

    html += "<ul>"
    all_hash_comments[comment.id].each do |child|
      next unless child.parent_comment_id == comment.id
      html += "<li>"
      html += best_list_comments(all_hash_comments, child)
      html += "</li>"
    end
    html += "</ul>"
    return html.html_safe
  end

end
