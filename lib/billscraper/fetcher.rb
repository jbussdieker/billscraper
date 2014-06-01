require 'capybara'

module BillScraper
  class Fetcher
    include Capybara::DSL

    attr_accessor :params

    def initialize(params = {})
      @params = params
    end

    def browser
      Capybara.current_session.driver.browser
    end

    def clear_cookies
      if browser.respond_to?(:clear_cookies)
        browser.clear_cookies
      elsif browser.respond_to?(:manage) and browser.manage.respond_to?(:delete_all_cookies)
        browser.manage.delete_all_cookies
      else
        raise "Error clearing cookies"
      end
    end

    def fetch(params = {})
      raise "Not implemented"
    end
  end
end

require 'billscraper/fetcher/pge'
require 'billscraper/fetcher/ebmud'
require 'billscraper/fetcher/att'
require 'billscraper/fetcher/acpe'
require 'billscraper/fetcher/alaskausa'
require 'billscraper/fetcher/adp'
require 'billscraper/fetcher/boa'
require 'billscraper/fetcher/discover'
require 'billscraper/fetcher/publicstorage'
