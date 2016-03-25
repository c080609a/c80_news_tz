Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']

  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
      scope: 'public_profile',
      info_fields: 'id,name,link'

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_SECRET'],
      scope: 'profile',
      image_aspect_ratio: 'square',
      image_size: 48,
      access_type: 'online',
      name: 'google',
      skip_jwt: true

  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'],
      scope: 'r_basicprofile',
      fields: %w'id first-name last-name location picture-url public_profile_url'
  
end
