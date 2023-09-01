class Tweet < ApplicationRecord
    validates :description, presence: true
    validates :username , presence: true

    # Se agrega gem pg-search para buscar
    include PgSearch::Model
    pg_search_scope :search_full_text, against: [
    [:description, 'A'],
    [:username, 'B']
    ]
end 
