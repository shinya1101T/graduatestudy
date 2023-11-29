class Reply < ApplicationRecord
    validates :user_id, {presence: true}
    validates :post_id, {presence: true}
    validates :reply, {presence:true,length:{maximum: 140}}
    belongs_to :post
end
