class Room < ActiveRecord::Base
  extend FriendlyId

  validates_presence_of :slug

  friendly_id :title, use: [:slugged, :history]

  has_many :reviews, dependent: :destroy
  has_many :reviewed_rooms, through: :reviews, source: :room
  belongs_to :user

  scope :most_recent, -> { order(created_at: :desc) }

  def complete_name
    "#{title}, #{location}"
  end

  def self.search query
    if query.present?
      where(['location LIKE :query OR title LIKE :query OR description LIKE :query', query: "%#{query}%"]);
    else
      all
    end
  end
end
