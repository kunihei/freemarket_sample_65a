module SetUser
  extend ActiveSupport::Concern

  private
  
  def set_user
    @user = User.find(params[:id])
  end
end