describe "Automation Tests" do

  before(:all) do

    @driver = Selenium::WebDriver.for :chrome

  end

  it "Test navigating the app" do

    @driver.get url
    expect(@driver.title).to eq "Poker Ladzzz"
    links = @driver.find_elements(css: ".qa-nav button")
    links[1].click
    expect(@driver.title).to eq "Login"
    links[2].click
    expect(@driver.title).to eq "Poker"


  end

  after(:all) do
    @driver.quit
  end

end
