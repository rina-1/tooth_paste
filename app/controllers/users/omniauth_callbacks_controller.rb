# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController  
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    # 保存されている時の処理
    if @user.persisted? 
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  # def facebook
  #   @user = User.from_omniauth(request.env["omniauth.auth"])
  #   if @user.persisted?  #もし@userがDBに既にいたら、ログイン状態にします  
  #     sign_in_and_redirect @user, event: :authentication 
  #     set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
  #   else #もし@userがDBにいない場合、新規登録ページにリダイレクトします
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     #データをsessionに入れることによって、新規登録ページの入力欄に、予め情報を入れておくなどが可能になります。
  #     redirect_to new_user_registration_path
  #   end
  # end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication 
      set_flash_message(:notice, :success, kind: 'google') if is_navigational_format?
    else
      #session["devise.google_data"] = request.env["omniauth.auth"][:info]
      session["devise.google_data"] = request.env["omniauth.auth"].except('extra')
      #google認証の場合は、なぜかauth_hashの容量が大きく、一瞬で容量オーバーとなるため、新規登録時に必要な情報のみをsessionに渡すこととしました。（おそらく画像データのせい？）
      redirect_to new_user_registration_url
    end
  end

# メガネくんから教えてもらったコード
  # def google
  #   @user = User.find_for_google(request.env['omniauth.auth'])

  #   if @user.persisted?
  #     flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
  #     sign_in_and_redirect @user, event: :authentication
  #   else
  #     session['devise.google_data'] = request.env['omniauth.auth']
  #     redirect_to new_user_registration_url
  #   end
  # end

end
