class User

  attr_reader :_id,
              :url,
              :external_id,
              :name,
              :alias,
              :created_at,
              :active,
              :verified,
              :shared,
              :locale,
              :timezone,
              :last_login_at,
              :email,
              :phone,
              :signature,
              :organization_id,
              :tags,
              :suspended,
              :role

  def initialize(attributes)
    @_id = attributes[:_id]
    @url = attributes[:url]
    @external_id = attributes[:external_id]
    @name = attributes[:name]
    @alias = attributes[:alias]
    @created_at = attributes[:created_at]
    @active = attributes[:active]
    @verified = attributes[:verified]
    @shared = attributes[:shared]
    @locale = attributes[:locale]
    @timezone = attributes[:timezone]
    @last_login_at = attributes[:last_login_at]
    @email = attributes[:email]
    @phone = attributes[:phone]
    @signature = attributes[:signature]
    @organization_id = attributes[:organization_id]
    @tags = attributes[:tags]
    @suspended = attributes[:suspended]
    @role = attributes[:role]
  end

  def to_s
    "User ##{_id} #{name}"
  end

end
