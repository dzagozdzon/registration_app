class UsersController < ApplicationController

    def new
      @user = User.new
      @address = @user.build_address
      @company = @user.build_company
      @company_address = @user.company.build_address
    end

    def create
      @user = User.create(users_params)
      if @user.save
        flash[:notice] = "Done!"
        redirect_to user_path(@user)
      else
        flash[:danger] = @user.errors.full_messages
        render new_user_path
      end

      def show
        @user = User.find(params[:id])
      end
    end
  
  
    private
  
    def users_params
      params.require(:user).permit(:first_name, :last_name, :email, :birthdate, :phone_number,
                                    { address_attributes: [:street, :city, :zip_code, :country],
                                      company_attributes: [:name, address_attributes: [:street, :city, :zip_code, :country]]
                                    })
    end
  end