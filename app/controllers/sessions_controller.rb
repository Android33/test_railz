class SessionsController < ApplicationController
  respond_to :json

  def create
    puts "---------------"
    puts params.inspect
    puts "---------------"

    email = params[:user_email]
    password = params[:user_password]

    user = User.find_by_email(email)
    token = nil
    name = nil
    surname = nil
    church_id = nil

    if user.valid_password?(password)
      token = user.authentication_token
      name = user.name
      surname = user.surname
      puts "========"
      church_id = user.church_id
      puts "========"
    end

    if token.present?
        puts "token"*10
      render json: {user_token: token, user_email: email, user_name: name, user_surname: surname, main_church_id: church_id}
      # render json: {user_token: token}

    else
        puts "error"*10
      render json: false, status: :unprocessable_entity
    end
  end
end
