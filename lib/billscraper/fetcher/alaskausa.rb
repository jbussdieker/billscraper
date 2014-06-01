module BillScraper
  class ALASKAUSAFetcher < Fetcher
    SITE_URL = "https://go.akusa.org"

    def login
      fill_in :userNumber, with: params[:user]
      click_button 'Log In'
      fill_in :password, with: params[:password]
      find(:xpath, "//input[@type='Submit']").click
    end

    def fetch_all
      list = []
      all(:xpath, "//span[@class='accts_bold']").each do |account|
        details = account.find(:xpath, "../../td[2]").text
        m = details.match(/Balance:\s+([$0-9\.,]+)\s+Available:\s+([$0-9\.,]+)/)

        item = {}
        item[:name] = account.text

        balance = m.captures[0]
        balance.gsub!(/[$,]/, "")
        item[:balance] = balance.to_f

        available = m.captures[1]
        available.gsub!(/[$,]/, "")
        item[:available] = available.to_f

        list << item
      end
      list
    end

    def fetch
      clear_cookies
      visit(SITE_URL)
      click_link "UltraBranch Log In"
      login
      fetch_all
    end
  end
end
