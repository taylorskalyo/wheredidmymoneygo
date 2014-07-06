class Expense < ActiveRecord::Base
  validates :amount, 
    presence: true, 
    :numericality => { :greater_than_or_equal_to => 0 }

  belongs_to :user
  belongs_to :owner, :class_name => :User
end
