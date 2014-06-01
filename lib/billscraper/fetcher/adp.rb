module BillScraper
  class ADPFetcher < Fetcher
    SITE_URL = "https://www.mykplan.com/ParticipantSecure_Net/login.aspx"
    BALANCE_XPATH = "//div[@id='portlet-accountbalance']//td[@class='big-text']"

    def login
      fill_in :txtUserID, with: params[:user]
      fill_in :txtPassword, with: params[:password]
      click_button ' Log In '
    end

    def fetch_balance
      balance = find(:xpath, BALANCE_XPATH).text
      balance.gsub!(/[$,]/, "")
      balance.to_f
    end

    def fetch
      clear_cookies
      visit(SITE_URL)
      within_frame "bottomFrame" do
        click_button 'I agree'
      end
      login
      balance = fetch_balance
      { balance: balance }
    end
  end
end
