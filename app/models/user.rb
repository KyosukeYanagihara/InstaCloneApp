class User < ApplicationRecord
  validates :name,  presence: true, length: { in: 1..30 }
  # MEMO: uniqueness
  validates :email, presence: true, length: { in: 1..255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { in: 8..16 }
  validates :image, presence: true
  before_validation { email.downcase! }
  has_secure_password
  # MEMO: unitialize ImageUploader -> ImageUloaderがない
  # MARK: ImageUloader
  # WHAT: ImageUploader は URL の代わりに ImageUploader のインスタンスとしてユーザの画像を扱う。
  # WHY: 基本的にはBINARY(png/jpeg)で保存します。ImageUploaderは、画像の仕組みを知らない人でも簡単に画像を扱えるようにしてくれます。具体的には、ImageUploaderはURLで画像を扱います。
  # HOW: rails g で ImageUploader ファイルを生成し、 mount_uploader で画像の colomn を定義します
  mount_uploader :image, ImageUploader
end