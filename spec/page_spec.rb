# frozen_string_literal: true

RSpec.describe Ahiru::Page, :vcr do
  let(:html) { HTTP.get("https://duckduckgo.com/html/", params: { q: "hoge" }).body.to_s }

  subject { Ahiru::Page.new html }

  describe "#next_page" do
    it "should return a Page" do
      expect(subject.next_page).to be_a(Ahiru::Page)
    end
  end

  describe "#results" do
    it "should return an array of Result" do
      expect(subject.results).to be_an(Array)
      expect(subject.results.first).to be_a(Ahiru::Result)

      expect(subject.results.first.title).to be_a(String)

      expect(subject.results.first.url).to be_a(String)
      expect(subject.results.first.url.start_with?("http")).to eq(true)

      expect(subject.results.first.snippet).to be_a(String)
    end
  end
end
