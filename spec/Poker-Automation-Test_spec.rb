describe "Automation Tests" do

  before(:each) do
    HTTParty.get url_api('/api/end')
    @driver = Selenium::WebDriver.for :chrome

  end

  it "Test navigating the app" do

    @driver.get url
    expect(@driver.title).to eq "Home"
    nav(1)
    @driver.find_element(id: "name-input").send_keys "John"
    nav(2)
    expect(@driver.title).to eq "Poker"

  end

  it "Check that the table layout is on the page" do

  login_play

  end

  it "Check that a deal has happened and the cards are displayed on the front end check the balance is reduced" do

    login_play
    sleep 2
    @driver.find_element(id: "deal").click
    sleep 2
    wait_for("usercard-one")
    find_card(2, "usercard")
    @driver.find_element(id: "raise").click

    sleep 4
    # balance = @driver.find_element(id: "balance").get_text
    # expect(balance).to < 500
    wait_for("flopcard-one")
    find_card(3, "flopcard")
    @driver.find_element(id: "raise").click
    sleep 4
    wait_for("flopcard-four")
    find_card(1, "flopcard", true, false)
    @driver.find_element(id: "raise").click
    sleep 4
    wait_for("flopcard-five")
    find_card(1, "flopcard", false, true)
    balance = @driver.find_element(id: "balance").attribute("innerHTML")
    expect(balance).to eq "Balance: 350"

  end


  after(:each) do
    HTTParty.get url_api('/api/end')
    @driver.quit
  end

end
