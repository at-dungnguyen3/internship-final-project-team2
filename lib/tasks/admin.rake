# frozen_string_literal: true

namespace :admin do
  desc 'Create admin account'
  task admin_account: :environment do
    User.create!(first_name: 'Administration', last_name: 'Nguyễn', email: 'admin@gmail.com', password: '123456', role: 1, activated?: true, activated_at: Time.now)
  end
end
