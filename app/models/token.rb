class Token < ActiveRecord::Base
  validates :user, presence: true

  belongs_to :user

  def as_json(*)
    super(:include => { :user => {} })
  end
end
