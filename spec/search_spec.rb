# frozen_string_literal: true

RSpec.describe Ahiru::API, :vcr do
  subject { Ahiru::API }

  describe ".search" do
    it "should return a Page" do
      expect(subject.search(q: "hoge")).to be_a(Ahiru::Page)
    end
  end
end
