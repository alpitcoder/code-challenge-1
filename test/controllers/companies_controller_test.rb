require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "City, State"
  end

  test "Update with zipcode change" do
    visit edit_company_path(@company)
    city = @company.city
    state = @company.state
    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Update Test Company")
      fill_in("company_zip_code", with: "12345")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Update Test Company", @company.name
    assert_equal "12345", @company.zip_code
    assert_not_equal city, @company.city
    assert_not_equal state, @company.state
  end

  test "Create with domain getmainstreet.com" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      fill_in("company_color", with: "#800000")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
    assert_equal "NC", last_company.state
  end

  test "Create without domain getmainstreet.com" do
    visit new_company_path
    count = Company.count
    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_email", with: "new_test_company@gmail.com")
      click_button "Create Company"
    end
    last_company = Company.last
    assert_not_equal "New Test Company", last_company.name
    assert_not_equal "28173", last_company.zip_code
    assert_equal(Company.count, count)
  end

  test "Update without domain getmainstreet.com" do
    @company = companies(:wolf_painting)
    visit edit_company_path(@company)
    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Update Test Company")
      fill_in("company_email", with: "update_test_company@gmail.com")
      click_button "Update Company"
    end
    @company.reload
    assert_not_equal "Update Test Company", @company.name
    assert_not_equal "update_test_company@gmail.com", @company.email
  end

  test "Destroy" do
    name = @company.name
    visit companies_path
    count = Company.count
    first('#delete_company').click
    page.driver.browser.switch_to.alert.accept
    assert_text "#{name} Company deleted successfully"
    assert_equal(Company.count, count - 1)
  end


end
