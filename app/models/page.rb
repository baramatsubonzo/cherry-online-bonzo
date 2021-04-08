class Page < ApplicationRecord
  include RankedModel
  ranks :row_order

  belongs_to :webbook
end
