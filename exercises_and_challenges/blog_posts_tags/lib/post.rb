class Post
  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :tags

  def initialize
    @tags = []
  end
end