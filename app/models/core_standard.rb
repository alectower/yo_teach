class CoreStandard < ActiveRecord::Base
  validates_presence_of :standard_type,
    :dot_notation, :uri, :guid, :description

  scope :ordered, -> { order(dot_notation: :asc) }
end
