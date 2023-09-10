class Movie < ApplicationRecord
    belongs_to :client

  def to_s
    self.title
  end
end
