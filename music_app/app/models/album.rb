class Album < ApplicationRecord
  belongs_to :band,
    primary_key: :id,
    foreign_key: :band_id,
    class_name: :Band

  validates :title, :year, presence: true

end
