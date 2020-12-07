RSpec.feature "index page" do
	scenario "root route" do
		visit root_path
		expect(page).to have_link("Sign in through Google")
		expect(page).to have_link("About Us")
		click_link "About Us"
		expect(page).to have_content("Who are we?")
		expect(page).to have_link("Go back to front page")
		expect(page).to have_current_path(about_path)
		click_link "Go back to front page"
		expect(page).to have_link("How to use")
		click_link "How to use"
		expect(page).to have_content("How to use")
		expect(page).to have_current_path(how_path)
		expect(page).to have_link("Go back to front page")
		click_link "Go back to front page"
		expect(page).to have_current_path(root_path)
	end
end
