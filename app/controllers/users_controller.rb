class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @movies = @user.parties.map { |party| MovieFacade.create_single_movie(party.movie_id) }
    @images = @user.parties.map { |party| MovieFacade.create_single_movie_images(party.movie_id) }
  end

  def new
    @user = User.new
  end

  def login_form

  end

  def login_user
    @user = User.find_by(email: params[:email])&.authenticate(params[:password])
    if @user.id != nil
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
    else
      flash[:error] = "invalid credential"
      render 'new'
    end
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Account Successfully Created'
      redirect_to "/users/#{@user.id}"
    else
      @user.errors.full_messages.each do |error|
      flash[:error] = error
    end
    render 'new'
  end

end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
