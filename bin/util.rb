module Util
  def Util.pluralize(n, singular, plural=nil)
    if n == 1
      singular
    elsif plural
      plural
    else
      "#{singular}s"
    end
  end
end
