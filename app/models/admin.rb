class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :rememberable, :omniauthable, omniauth_providers: [:google_oauth2]
end
