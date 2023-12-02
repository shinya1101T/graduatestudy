class User < ApplicationRecord
    has_secure_password
    VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/
    validates :password, presence: true,
      format: { with: VALID_PASSWORD_REGEX,
      message: "は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります"}
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
