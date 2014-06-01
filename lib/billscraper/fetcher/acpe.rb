module BillScraper
  class ACPEFetcher < Fetcher
    SITE_URL = "https://acpe.alaska.gov/Login"
    DUE_DATE_XPATH = "//span[@id='dnn_ctr2546_AccountAtAGlance_ltDueDate']"
    AMOUNT_XPATH = "//span[@id='dnn_ctr2546_AccountAtAGlance_ltTotalMinMonthlyPayment']"
    BALANCE_XPATH = "//span[@id='dnn_ctr2546_AccountAtAGlance_ltOutstandingBalance']"

    def login
      fill_in :txtUsername_3541, with: params[:user]
      fill_in :txtPassword_3541, with: params[:password]
      click_button 'Login'
    end

    def fetch_due_date
      due_date = find(:xpath, DUE_DATE_XPATH).text
      Date.strptime(due_date, "%m/%d/%Y")
    end

    def fetch_amount
      amount = find(:xpath, AMOUNT_XPATH).text
      amount.gsub!(/[$,]/, "")
      amount.to_f
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
      visit("https://acpe.alaska.gov/MY_ACCOUNTS")
      amount = fetch_amount
      due_date = fetch_due_date
      balance = fetch_balance
      { balance: balance, amount: amount, due_date: due_date }
    end
  end
end
