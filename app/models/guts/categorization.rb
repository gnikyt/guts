module Guts
  # Categorization joiner which connects
  # Catgory model and Content model
  class Categorization < ApplicationRecord
    belongs_to :category
    belongs_to :content
  end
end
