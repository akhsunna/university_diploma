class ProjectMethodologyScore < ApplicationRecord
  belongs_to :project
  belongs_to :methodology
end
