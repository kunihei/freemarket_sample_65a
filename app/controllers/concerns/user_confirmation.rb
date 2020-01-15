module UserConfirmation
  extend ActiveSupport::Concern

  private
  def user_confirmation
    if @user.id != current_user.id
      flash[:alert] = "該当ユーザーではありません"
      redirect_to root_path
    end
  end
end