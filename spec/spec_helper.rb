RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end


require 'rspec'
require 'httparty'
require 'selenium-webdriver'
require 'yaml'
require 'json'
require 'pry'
require 'humanize'

def url(path = '')
  ('http://localhost:8000' + path)
end

def login_play
  @driver.get url
  nav(1)
  @driver.switch_to.alert.send_keys("John")
  @driver.switch_to().alert().accept()
  expect(@driver.title).to eq "Login"
  nav(2)
  expect(@driver.title).to eq "Poker"
  poker_table = @driver.find_element(id: "poker-table")
end

def wait_for(element)
  wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  begin
    element = wait.until { @driver.find_element(id: element) }
  end

end

def nav(value)
  links = @driver.find_elements(css: ".qa-nav button")
  links[value].click
end

def wait_for_alert
  status = true
  while (status)
    alert = @driver.switch_to.alert rescue "exception happened"
    if (alert == "exception happened")
        status = true
        alert = "nothing happened"
      else
        status = false
      end
    end
end

def find_card(value, string, four = false, five = false)

  if four == true
    value.times { |i| i = i+4; i = i.humanize;  @driver.find_element(id: "#{string}-#{i}")}
  elsif five == true
    value.times { |i| i = i+5; i = i.humanize;  @driver.find_element(id: "#{string}-#{i}")}
  else
    value.times { |i| i = i+1; i = i.humanize;  @driver.find_element(id: "#{string}-#{i}")}
  end


end
