class Chmod
  include ActiveModel::Conversion

  def mode
    "0644" # FIXME make this dynamic
  end

  def user_description
    "read and write" # FIXME make this dynamic
  end

  def group_description
    "read" # FIXME make this dynamic
  end

  def other_description
    "read" # FIXME make this dynamic
  end
end
