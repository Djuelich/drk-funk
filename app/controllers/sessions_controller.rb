class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  skip_before_filter :require_login
  # GET /sessions/new
  def new
    redirect_to '/starts' if logged_in?
  end

  # POST /sessions
  # POST /sessions.json
  def create
    user = User.authenticate(params[:username], params[:password_unhashed])
    if user
      if true #user.activated == true #evtl user.activated?
        log_in user
        params[:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to root_url
        flash[:success] ="Login erfolgreich"
      else
        flash[:warning] ="Account noch nicht aktiviert. Aktivierungslink wurde an Ihre Email gesendet."
      end
    else
        redirect_to root_url
      flash[:error] ="Falsche Benutzereingabe/n"
    end
  end

  def remove
      log_out if logged_in?
      redirect_to root_url
  end
end