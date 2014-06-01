module BillScraper
  class PGEFetcher < Fetcher
    SITE_URL = 'http://www.pge.com'
    BALANCE_XPATH = "//div[@class='row amount-due']/div[@class='value']/span[1]"
    DUE_DATE_XPATH = "//div[@class='label' and text()='Due Date']/../div[2]/span"

    def login
      fill_in :username, with: params[:user]
      fill_in :password, with: params[:password]
      click_button "login-btn"
    end

    def fetch_balance
      balance = find(:xpath, BALANCE_XPATH).text
      balance.gsub!(/[$,]/, "")
      balance.to_f
    end

    def fetch_due_date
      due_date = find(:xpath, DUE_DATE_XPATH).text
      Date.strptime(due_date, "%m/%d/%y")
    end

    def fetch
      clear_cookies
      visit(SITE_URL)
      login
      balance = fetch_balance
      due_date = fetch_due_date
      { balance: balance, due_date: due_date }
    end
  end
end
