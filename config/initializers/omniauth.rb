# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '619976771901-mnt9vgbs81qgq8094cdrjov78qns5ht0.apps.googleusercontent.com', 'Fw5V2EEkdvd060ouY0KgtF_3'
end
