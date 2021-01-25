require "test_helper"
require "application_system_test_case"

class CompanyTest < ActiveSupport::TestCase

  test "Invalid Company email" do
    company = Company.new(name: "Mainstreet-test", email: "mainstreet-test@gmail.com", zip_code: "12345")
    assert_not company.valid?
  end

  test "Valid Company email" do
    company = Company.new(name: "Mainstreet-test", email: "mainstreet-test@getmainstreet.com", zip_code: "12345")
    assert company.valid?
  end

  test "Zip data present for Zip code" do
    company = Company.create!(name: "Mainstreet-test", email: "mainstreet-test@getmainstreet.com", zip_code: "12345")
    assert_equal "NY", company.state
    assert_equal "Schenectady", company.city
  end

  test "Zip data blank for Zip code" do
    company = Company.create!(name: "Mainstreet-test", email: "mainstreet-test@getmainstreet.com", zip_code: "1")
    assert_equal nil, company.state
    assert_equal nil, company.city
  end

end
