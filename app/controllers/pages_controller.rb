class PagesController < ApplicationController
  before_filter :require_admin!, :only => :admins
  def privacy
  end

  def about
  end

  def api
  end

  def blog
  end

  def contact
  end

  def terms
  end
  
  def admins
  end

end
