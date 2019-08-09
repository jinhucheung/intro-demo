Intro.configure do
  # switch intro status. all tours don't display if intro is disable. default: true
  # self.enable = true

  # class name of your User Modal, default: 'User'
  # self.user_class = 'User'

  # current_user method name in your controller, default: 'current_user'
  # self.current_user_method = 'current_user'

  # after user touches a tour more than max count, the tour doesn't display. default: 1
  # self.max_touch_count = 1

  # admin account for accessing backstage, default by SecureRandom#urlsafe_base64
  self.admin_username = ENV['INTRO_APP_ADMIN_USERNAME'] || "FKlqCs2"
  self.admin_password = ENV['INTRO_APP_ADMIN_PASSWORD'] || "s-NiTUcU0jU1v2ujXRszNgR02ns"

  # admin_authenticate_account will override authenticate_acount process for backstage, it should return boolean
  # self.admin_authenticate_account = -> { current_user.try(:has_admin_role?) }

  # redirect to unauthenticated_admin_path if user is failed to authenticated, default: '/intro/admin/sessions/new'
  # self.unauthenticated_admin_path = '/login'

  # the path for sign out an admin, default: '/intro/admin/sessions/sign_out'
  # self.sign_out_admin_path = '/logout'

  # the storage of carrierwave, default: :file
  # self.carrierwave_storage = :file

  # cache tours status to reduce requests, default: false
  # use `Rails.cache` to store tours status, change `config.cache_store` for different strategies in environment
  self.cache = true
end

Intro::Admin::ToursController.class_eval do
  before_action :limit_default_tours, only: [:update, :destroy, :publish]

  private

  def limit_default_tours
    return if [1, 2, 3].exclude?(@tour.id) || allow_access_token?

    respond_to do |format|
      format.html { redirect_to admin_tours_path }
      format.any  { head :forbidden  }
    end
  end

  def allow_access_token?
    '58c3d6dcc375cbf28ac50cbfe492760f08e9af2b' == Digest::SHA1.hexdigest(params[:access_token].to_s)
  end
end