class Currency < ActiveRecord::Base

  def dollars?
    currency == "dollars"
  end

  def colones?
    currency == "colones"
  end
end
