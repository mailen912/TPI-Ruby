class UsersController < ApplicationController
  load_and_authorize_resource
  #before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    puts "ACAAAAAAAAAAAAAA"
    pass= params[:user][:password]
    role= params[:user][:role]
    email= params[:user][:email]
    puts pass
    puts role.class
    puts role
    puts email
    role=role.to_i
    #@user = User.new(email:email,password:pass,role:role)

    #if @user.save
    #  redirect_to @user, notice: 'User was successfully created.'
    #else
    #  render :new
    #end
  end

  # PATCH/PUT /users/1
  def update
    pass= params[:user][:password]
    role= params[:user][:role]
    email= params[:user][:email]
    puts pass
    puts role.class
    puts role
    puts email
    role=role.to_i
    if @user.update(email:email,password:pass,role:role)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :role)
    end
end
