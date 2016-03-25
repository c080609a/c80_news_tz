module C80NewsTz
  class User < ActiveRecord::Base

    def self.from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.name = auth_hash['info']['name']
      user.location = get_social_location_for user.provider, auth_hash['info']['location']
      user.image_url = auth_hash['info']['image']
      user.url = get_social_url_for user.provider, auth_hash['info']['urls'] #[user.provider.capitalize]
      user.save!
      user
    end

    private

    # LinkedIn’s authentication hash is a bit different from the ones that we’ve seen up to now:
    # * location is a nested hash with country’s code and name.
    # * urls is also a nested hash, but there is no LinkedIn key. Instead, there is a
    #   public_profile key and probably a bunch of others (storing personal web site and things like that).
    # This introduces some complexity to the parsing methods:

    def self.get_social_location_for(provider, location_hash)
      case provider
        when 'linkedin'
          location_hash['name']
        else
          location_hash
      end
    end

    def self.get_social_url_for(provider, urls_hash)
      case provider
        when 'linkedin'
          urls_hash['public_profile']
        else
          urls_hash[provider.capitalize]
      end

    end

  end

end