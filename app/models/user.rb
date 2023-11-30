class User < ApplicationRecord
    has_secure_password
    validates :name, {presence: true}
    validates :email, {presence: true,uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }}
    enum role: { general: 0, admin: 1 }
    def posts
      return Post.where(user_id: self.id)
    end  

    def self.search(search)
      if search
        where(['name LIKE ?', "%#{search}%"])
      else
        all
     end
  end
end
