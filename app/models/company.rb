class Company < ApplicationRecord
  has_rich_text :description

  validate :email_validator, on: [:create, :update], if: Proc.new { |company| company.email.present? }

  before_save :update_city_and_state, if: :zip_code_changed?


  def email_validator
    whitelist_domain = "getmainstreet.com"
    email_domain = email.split("@").last
    unless whitelist_domain.include?(email_domain)
      errors.add(:base, "Only #{whitelist_domain} domain is allowed")
    end
  end

  def update_city_and_state
    zip_data = ZipCodes.identify(zip_code)
    self.city = zip_data.present? ? zip_data[:city] : nil
    self.state = zip_data.present? ? zip_data[:state_code] : nil
  end

end
