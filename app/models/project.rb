class Project < ApplicationRecord
    belongs_to :user
    has_many :bugs
    validates :title, presence: true, length: { minimum: 6 }
end