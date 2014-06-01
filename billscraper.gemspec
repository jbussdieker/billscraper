Gem::Specification.new do |gem|
  gem.name = "billscraper"
  gem.version = "0.0.1"
  gem.authors = ["Joshua B. Bussdieker"]
  gem.summary = "Gather information about you bills without all the clicking and password memorization."

  gem.add_runtime_dependency 'selenium-webdriver'
  gem.add_runtime_dependency 'capybara'
  gem.add_runtime_dependency 'rspec'
end
