class ToolTag < Tag
  has_many :common_tools, foreign_key: :tag_id

end
