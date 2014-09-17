module Initial
  class DeviseOauthGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      gem 'omniauth-facebook'
      gem 'omniauth-vkontakte'
      gem 'omniauth-odnoklassniki'

      copy_file 'devise_oauth/devise_oauth.rb',
                'config/initializers/devise_oauth.rb'

      insert_into_file 'config/secrets.yml', after: "development:\n" do
%q{
  fb_app:  '267206890544721'
  fb_key:  '40aba0555fb761272b07711e30ebe371'
  vk_app:  '4470254'
  vk_key:  'J7ANCTdIWb8SAKzA4eUk'
  ok_app:  '1096984323'
  ok_key:  '792DB3D2757C2A786C2AD5EA'
  ok_pkey: 'CBADHHFCABABABABA'
}
      end

      insert_into_file 'config/secrets.yml', after: "production:\n" do
%q{
  fb_app:  <%= ENV["FB_APP"] %>
  fb_key:  <%= ENV["FB_KEY"] %>
  vk_app:  <%= ENV["VK_APP"] %>
  vk_key:  <%= ENV["VK_KEY"] %>
  ok_app:  <%= ENV["OK_APP"] %>
  ok_key:  <%= ENV["OK_KEY"] %>
  ok_pkey: <%= ENV["OK_PKEY"] %>
}
      end

      generate 'migration', 'AddColumnsToUsers provider uid auth_info:text'
      rake 'db:migrate'
      insert_into_file 'app/models/user.rb', before: "end\n" do
%q{
  serialize :auth_info, JSON

  devise :omniauthable, omniauth_providers: [:facebook, :vkontakte, :odnoklassniki]

  def self.from_omniauth(auth_hash)
    auth = auth_hash['auth_hash'].with_indifferent_access
    find_or_create_by(provider: auth[:provider], uid: auth[:uid]) do |user|
      user.email = auth[:info][:email] || "#{auth[:uid]}@example.com"
      user.password = Devise.friendly_token[0,20]
      user.info = auth.try(:to_json)
    end
  end

}
      end

      append_to_file 'app/views/welcome/index.haml' do
%q{
%ul.nav
  - if user_signed_in?
    %li= link_to "#{current_user.email} (#{current_user.provider})", '#'
    %li= link_to "Sign out", destroy_user_session_path, :method => :delete
  - else
    %li= link_to "Sign in with Facebook", user_omniauth_authorize_path(:facebook)
    %li= link_to "Sign in with Vkontakte", user_omniauth_authorize_path(:vkontakte)
    %li= link_to "Sign in with Odnoklassniki", user_omniauth_authorize_path(:odnoklassniki)
}
      end

      copy_file 'devise_oauth/omniauth_callbacks_controller.rb',
                'app/controllers/users/omniauth_callbacks_controller.rb'


      oauth_without_other_auths = ask 'Use oauth without other authentications? (y/n)'
      content = if oauth_without_other_auths
%q{
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'#, as: :new_user_session
    get 'sign_out', to: 'devise/sessions#destroy'#, as: :destroy_user_session
end
}
      else
%q{
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy'#, as: :destroy_user_session
  end
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

}
      end

      comment_lines 'config/routes.rb', /devise_for/

      route content
    end
  end
end
