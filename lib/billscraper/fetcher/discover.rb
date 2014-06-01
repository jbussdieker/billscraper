module BillScraper
  class DISCOVERFetcher < Fetcher
    SITE_URL = "https://www.discover.com/"
    BALANCE_XPATH = "//li[text()='Current Balance']/../li[@class='amount']"
    
    def login
      fill_in 'login-account', with: params[:user]
      fill_in 'login-password', with: params[:password]
      find(:xpath, "//a[@class='selector']").click
      click_link "Discover Card"
      find(:xpath, "//input[@id='login-button']").click
    end

    def fetch_balance
      balance = find(:xpath, BALANCE_XPATH).text
      balance.gsub!(/[$,]/, "")
      balance.to_f
    end

    def fetch
      clear_cookies
      visit(SITE_URL)
      login
      { balance: fetch_balance }
    end
  end
end
