module BillScraper
  class ATTFetcher < Fetcher
    SITE_URL = 'http://www.att.com'
    AMOUNT_XPATH = "//span[text()='Most recent bill']/../../div[2]/span"
    DUE_DATE_XPATH = "//p[text()='Total Amount Due by ']/b"
    BALANCE_XPATH = "//h3[contains(text(),'Your total balance is:')]/../../div[2]/span"

    def login
      fill_in :userid, with: params[:user]
      fill_in :userPassword, with: params[:password]
      click_button "tguardLoginButton"
    end

    def login_passcode
      fill_in :passcode, with: params[:passcode]
      click_button "bt_continue"
    end

    def fetch_amount
      amount = find(:xpath, AMOUNT_XPATH).text
      amount.gsub!(/[$,]/, "")
      amount.to_f
    end

    def fetch_due_date
      due_date = find(:xpath, DUE_DATE_XPATH).text
      Date.strptime(due_date, "%b %d, %Y")
    end

    def fetch_balance
      balance = find(:xpath, BALANCE_XPATH).text
      balance.gsub!(/[$,]/, "")
      balance.to_f
    end

    def fetch
      clear_cookies
      visit(SITE_URL)
      check_popup
      login
      check_popup

      if params[:passcode]
        login_passcode
        check_popup
      end

      amount = fetch_amount
      balance = fetch_balance
      click_link("View bill details")
      check_popup
      due_date = fetch_due_date

      { balance: balance, amount: amount, due_date: due_date }
    end

    private

    def check_popup
      begin
        popup = find(:xpath, "//div[@class='fsrFloatingContainer']")
      rescue Exception => e
      end

      if popup
        find(:xpath, "//div[@class='fsrFloatingContainer']//a[@title='Click to close.']").click
      end
    end
  end
end
