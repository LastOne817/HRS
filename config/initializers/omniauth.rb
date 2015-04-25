OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '1422989198008919', 'd9cda9769eb1294aca76e83874ba5ca9',
        :scope => 'email,user_birthday,read_stream'
end
