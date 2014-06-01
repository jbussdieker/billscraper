module BillScraper
  class EBMUDFetcher < Fetcher
    SITE_URL = 'https://www.ebmud.com/customers/my-account'
    AMOUNT_XPATH = "//table[@id='ctl00_main_Tabs_tabpanelViewStatements_GridViewViewStatements']//tr[2]//tr/td[4]/span"
    DUE_DATE_XPATH = "//table[@id='ctl00_main_Tabs_tabpanelViewStatements_GridViewViewStatements']//tr[2]//tr/td[3]/span"

    def login
      fill_in 'ctl00_main_txtEmail', with: params[:user]
      fill_in 'ctl00_main_txtPassword', with: params[:password]
      click_button "ctl00_main_btnLogin"
    end

    def fetch_amount
      amount = find(:xpath, AMOUNT_XPATH).text
      amount.gsub!(/[$,]/, "")
      amount.to_f
    end

    def fetch_due_date
      due_date = find(:xpath, DUE_DATE_XPATH).text
      Date.strptime(due_date, "%m/%d/%Y")
    end

    def fetch
      clear_cookies
      visit(SITE_URL)
      within_frame "iframe-0" do
        click_link "Login"
        login
        find(:xpath, "//span[@id='__tab_ctl00_main_Tabs_tabpanelViewStatements']").click
        amount = fetch_amount
        due_date = fetch_due_date
        return { amount: amount, due_date: due_date }
      end
    end
  end
end
