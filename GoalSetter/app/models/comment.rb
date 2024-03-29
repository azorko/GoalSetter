class Comment < ActiveRecord::Base
  
  validates :body, :commentable_id, :commentable_type, presence: true
  
  belongs_to :commentable, polymorphic: true
  
  belongs_to(
  :author,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id
  )
end
