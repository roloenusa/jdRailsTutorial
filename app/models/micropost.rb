class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  
  belongs_to :user
  
  # The tutorial contains the following
  default_scope :order => 'microposts.created_at DESC'
  # this doesn't seem to work. A quick google resolved to a working solution:
  #default_scope order('microposts.created_at DESC') 
  
  # return microposts from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by (user) }
  
  
  # def self.from_users_followed_by(user)
  #   where(:user_id => user.following.push(user))
  # end
  
private 
  # return an SQL condition for users followed by the given user.
  # we include the user's own id as well
  def self.followed_by(user)
    following_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id)
    where("user_id IN (#{following_ids}) or user_id = :user_id", { :user_id => user})
  end
end

# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

