module Guts
  # Categorization joiner which connects
  # Catgory model and Content model
  # @see Guts::Category
  # @see Guts::Content
  class Categorization < ActiveRecord::Base
    belongs_to :category
    belongs_to :content
  end
end
