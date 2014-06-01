module BillScraper
  class PUBLICSTORAGEFetcher < Fetcher
    SITE_URL = 'https://www.publicstorage.com/Selfcare/summary.aspx'

    def login
      fill_in :loginname, with: params[:user]
      fill_in :loginpw, with: params[:password]
      click_button 'btnLogin'
    end

    def fetch_next_payment_info
      next_payment_info = find(:xpath, "//div[@id='sc_next_payment_info']").text
    end

    def fetch
      clear_cookies
      visit(SITE_URL)
      login
      { next_payment_info: fetch_next_payment_info }
    end
  end
end
