require "faraday"
require "nokogiri"
require "mechanize"
require "webdrivers"
require "watir"

url = "https://www.harristeeter.com/specials/weekly-list"
browser = Watir::Browser.new :chrome, headless: true
# agent = Mechanize.new

# url = "test.html"


if url
  browser.goto(url)
  browser.div(class: "product_infoBox").wait_until_present
  puts browser.title
  browser.close
else
  fail "You must provide a URL to fetch data from."
end

# agent.get(url)
