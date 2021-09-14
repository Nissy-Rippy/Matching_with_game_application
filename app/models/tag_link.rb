class TagLink < ApplicationRecord
   acts_as_taggable
   belongs_to :post
end
