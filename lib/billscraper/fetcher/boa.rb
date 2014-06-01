module BillScraper
  class BOAFetcher < Fetcher
    SITE_URL = "https://www.bankofamerica.com/"

    def login
      fill_in :id, with: params[:user]
      click_button 'hp-sign-in-btn'
      fill_in 'tlpvt-passcode-input', with: params[:password]
      click_link 'passcode-confirm-sk-submit'
    end

    def fetch_all
      list = []
      all(:xpath, "//div[contains(@class,'account-row')]").each do |account|
        name = account.find(:xpath, "./div[@class='left-column-content']").text
        balance = account.find(:xpath, "./div[@class='right-column-content']").text

        item = {}
        item[:name] = name.gsub("Show details for ", "")
        balance.gsub!(/[$,]/, "")
        item[:balance] = balance.to_f

        list << item
      end
      list
    end

    def fetch
      clear_cookies
      visit(SITE_URL)
      login
      fetch_all
    end
  end
end
