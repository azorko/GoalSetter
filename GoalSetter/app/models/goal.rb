class Goal < ActiveRecord::Base
  validates :title, :user_id, presence: true
  validates :pub, :completed, inclusion: { in: [true, false] }
  belongs_to :user
  
  before_save :default_values
    def default_values
      self.completed ||= false
      self.pub ||= false
      return 
    end
    
    has_many :comments, as: :commentable
end
