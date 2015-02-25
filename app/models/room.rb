class Room < ActiveRecord::Base
  belongs_to :user

  scope :most_recent, -> { order(created_at: :desc) }

  def complete_name
    "#{title}, #{location}"
  end
end
