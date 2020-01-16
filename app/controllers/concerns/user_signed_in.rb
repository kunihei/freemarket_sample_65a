module UserSignedIn
  extend ActiveSupport::Concern

  private
  def user_signed_in
    unless user_signed_in?
      flash[:alert] = "サインインしてください"
      redirect_to new_user_path
    end
  end
end