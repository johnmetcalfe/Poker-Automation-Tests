describe "Automation Tests" do

  before(:each) do

    @driver = Selenium::WebDriver.for :chrome

  end

  it "Test navigating the app" do

    @driver.get url
    expect(@driver.title).to eq "Poker Ladzzz"
    nav(1)
    @driver.switch_to.alert.send_keys("John")
    @driver.switch_to().alert().accept()
    nav(2)
    expect(@driver.title).to eq "Poker"

  end

  it "Check that the table layout is on the page" do

  login_play

  end

  it "Check that a deal has happened and the cards are displayed on the front end" do

    login_play
    @driver.find_element(id: "deal").click
    wait_for("usercard-one")
    find_card(2, "usercard")
    @driver.find_element(id: "bet-amount").send_keys 15
    @driver.find_element(id: "raise").click
    wait_for("flopcard-one")
    find_card(3, "flopcard")
    @driver.find_element(id: "raise").click
    wait_for("flopcard-four")
    find_card(1, "flopcard", true, false)
    @driver.find_element(id: "raise").click
    wait_for("flopcard-five")
    find_card(1, "flopcard", false, true)


  end

  after(:each) do
    @driver.quit
  end

end
