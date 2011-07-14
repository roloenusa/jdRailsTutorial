class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  
  belongs_to :user
  
  # The tutorial contains the following
  # default_scope :order => 'microposts.created_at DESC'
  # this doesn't seem to work. A quick google resolved to a working solution:
  default_scope order('microposts.created_at DESC') 
  
end
