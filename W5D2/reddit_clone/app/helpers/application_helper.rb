module ApplicationHelper
  def auth_token
    "<input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\"/>".html_safe
  end

  def count_votes(votable)
    votes = votable.votes
    count = votes.map{|vote| vote.value}.inject(0, :+)
    "(#{count})"
  end
end
