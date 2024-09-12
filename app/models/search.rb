class Search < ApplicationRecord
  validates :query, presence: true
  validates :scope, presence: false
  enum scope: %w[ people companies ].index_by(&:itself)
end
