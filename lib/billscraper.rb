require 'billscraper/fetcher'

module BillScraper
  def self.configure
    Capybara.run_server = false

    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end

    Capybara.default_driver = :chrome
    Capybara.javascript_driver = :chrome
  end
 
  def self.fetch(type, params = {})
    configure
    fetcher = BillScraper.const_get("#{type.to_s.upcase}Fetcher").new(params)
    fetcher.fetch
  end
end
