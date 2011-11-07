class PeopleController < InheritedResources::Base
  custom_actions  :resource => [:claim, :photo]

  before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :require_owner_or_admin!, :only => [:edit, :update, :destroy]
  before_filter :pick_photo_input, :only => [:update, :create]
  before_filter :set_user_id_if_admin, :only => [:update, :create]
  before_filter :require_admin!, :only => :list

  def index
    @people = Person.all
  end
  
  def list
    @search = Person.search(params[:search])
    @people = @search.paginate(
      :per_page => 50, :page => params[:page])
  end

  def tag
    @tag = params[:tag]

    tag! do |format|
      format.html { render :action => :index }
    end
  end

  def show
    @person = Person.find(params[:id])
    show!
  end

  def new
    if params[:q].present? && params[:authentications].present?
      query = params[:q]
      authentications = params[:authentications].keys

      @found_people = []
      current_user.authentications.find(authentications).each do |auth|
        if auth.api_client
          @found_people += auth.api_client.search(query)
        end
      end

      @found_people = Person.all(:conditions => ['name LIKE ?', "%#{query}%"]) + @found_people

    end

    new!
  end

  def create
      @person = Person.new(params[:person])
      @person.user = current_user
      @person.imported_from_provider = current_user.authentications.first.provider
      @person.imported_from_id = current_user.authentications.first.uid
      create!
  end

  def claim
    if resource.user.present?
      flash[:error] = "This person has already been claimed."
      redirect_to(:action => 'show') and return
    end
  end

  protected

  def require_owner_or_admin!
    authenticate_user! and return unless current_user

    unless current_user.admin? || current_user == resource.user
      flash[:warning] = "You aren't allowed to edit this person."
      redirect_to person_path(@person)
    end
  end

  def pick_photo_input
    params.delete(:photo_import_label) if params[:photo].present?
  end

  def set_user_id_if_admin
    if current_user.admin? && params[:person] && params[:person][:user_id].present?
      resource.user_id = params[:person][:user_id]
    end
  end
end
