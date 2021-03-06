module PostsHelper

  def display_likes(post)
    votes = post.votes_for.up.by_type(User)
    return list_likers(voters) if votes.size <= 8
    count_likers(votes)
  end

  def likers_of(post)
    votes = post.votes_for.up.by_type(User)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.user_name, profile_path(voter.user_name), class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end

  def liked_post(post)
    return 'glyphicon-heart' if current_user.voted_for? post
    'glyphicon-heart-empty'
  end

  private

  def list_likers(votes)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.user_name, profile_path(voter.user_name), class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end

end
