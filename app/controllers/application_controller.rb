require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :json, :xml

  protect_from_forgery

  protected

  def require_admin!
    authenticate_user! and return unless current_user
    unless current_user.admin?
      flash[:error] = "You need to be an admin to do that."
      redirect_to root_path and return
    end
  end

  def random_sort_clause
    seed = session["#{controller_name}_random_sort_seed"] ||= rand(2147483647)
    direction = %w(asc desc).include?(params[:order]) ? params[:order].upcase : ''

    "RAND(#{seed}) #{direction}"
  end

  def clear_random_sort_seed
    session["#{controller_name}_random_sort_seed"] = nil
  end

  def filter_sort_and_paginate(collection, default_order_random = false)
    collection = collection.tagged_with(params[:tag]) if params[:tag].present?

    if params[:column].eql?('random') || (params[:column].nil? && default_order_random)
      collection = collection.order(random_sort_clause)
    else
      clear_random_sort_seed
      collection = collection.sorty(params)
    end

    if params[:page] != 'all'
      collection.paginate(:page => params[:page], :per_page => params[:per_page] || params[:grid] ? 28 : 30)
    else
      collection
    end
  end

  def current_person
    current_user && current_user.person
  end
  helper_method :current_person    

  def page_title(value=nil)
    @page_title = value unless value.nil?

    if @page_title.nil?
      @page_title ||=
        case action_name.to_sym
        when :index
          controller_name.titleize
        when :new, :create
          "New " + controller_name.singularize.humanize.downcase
        when :edit, :update
          "Edit " + controller_name.singularize.humanize.downcase
        when :destroy
          "Destroy " + controller_name.singularize.humanize.downcase
        else
          begin
            get_resource_ivar.name
          rescue Exception => e
            controller_name.singularize.humanize.titleize
          end
        end
    else
      @page_title
    end
  end
  helper_method :page_title

  def find_team
    if params[:team_name] || params[:id]
      if params[:team_name]
        @team = Team.where(:name => params[:team_name].downcase).first
      elsif params[:id]
        @team = Team.where(:id => params[:id]).first
      end
    end
  end
  helper_method :find_team

  def check_team_admin
    find_team
    @team.admin?(current_user) || current_user.admin?
  end
  helper_method :check_team_admin

  def check_core_team
    find_team
    @team.app.admin?(current_user) || current_user.admin?
  end
  helper_method :check_core_team

end
