class Game < ActiveRecord::Base
   has_many :screenshots, dependent: :destroy
   accepts_nested_attributes_for :screenshots, :reject_if => lambda { |a| a[:url].blank? }, :allow_destroy => true
  
   has_many :game_categorizations, dependent: :destroy
   has_many :categories, through: :game_categorizations
  
   before_save { email.downcase! unless email.nil? }
  
   validates :name, presence: true, length: { maximum: 50 }
   validates :description, presence: true
   validates :version, length: { maximum: 30 }
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
   validates :email, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }, :allow_blank => true 
   validates :webpage, length: { maximum: 100 }, :url => true, :allow_blank => true
   validates :banner_icon_url, length: { maximum: 300 }, :url => true, :allow_blank => true
   validates :banner_image_url, length: { maximum: 300 }, :url => true, :allow_blank => true

   def assign_category!(category) 
     game_categorizations.create!(category_id: category.id)
   end
   
   def category?(category)
     game_categorizations.find_by(category_id: category.id)
   end
   
   def remove_from_category!(category)
     game_categorizations.find_by(category_id: category.id).destroy
   end
end
