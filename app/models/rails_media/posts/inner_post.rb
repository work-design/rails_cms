class InnerPost < Post
  validates :code, uniqueness: { scope: :type }, allow_blank: true

end
