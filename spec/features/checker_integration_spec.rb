require "spec_helper"

describe "checking chmod syntax" do
  let(:valid_mode) { "0644" }
  let(:invalid_mode) { "asdfadfaesf" }

  it "explains the given chmod mode" do
    submit_mode valid_mode
    expect_chmod_explaination valid_mode
  end

  it "gracefully handles invalid chmod mode" do
    submit_mode invalid_mode
    expect_invalid_mode
  end

  it "gracefully handles missing chmod mode" do
    submit_mode ""
    expect_missing_mode
  end

  def submit_mode(mode)
    visit root_path
    fill_in "statement", with: mode
    click_button "Submit"
  end

  def expect_chmod_explaination(mode)
    expect(page).to have_content(mode)
    expect(page).to have_css("[data-mode-role=user]", text: /read and write/)
    expect(page).to have_css("[data-mode-role=group]", text: /read/)
    expect(page).to have_css("[data-mode-role=other]", text: /read/)
  end

  def expect_invalid_mode
    expect(page).to have_content("Invalid chmod mode '#{invalid_mode}'.")
  end

  def expect_missing_mode
    expect(page).to have_content("You must provide a chmod mode statement.")
  end
end
