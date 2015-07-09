require 'rails_helper'

describe ApplicationHelper do
  it "should exist" do
    expect(ApplicationHelper.class).to eq Module
  end

  describe ".clean_datetime" do
    it "should be present" do
      ApplicationHelper.methods.include? :clean_datetime
    end

    it "should convert to propper datetime string format" do
      [Time.parse("2015-05-17 23:50:32"), "2015-05-17 23:50:32"].each do |datetime|
        expect( clean_datetime(datetime) ).to eq "2015-05-17 23:50:32"
      end
    end

    it "should return nil for wrong datetime inputs" do
      ["abcd", 12345, "", nil].each do |datetime|
        expect( clean_datetime(datetime) ).to eq nil
      end
    end
  end

  describe ".clean_time" do
    it "should be present" do
      ApplicationHelper.methods.include? :clean_time
    end

    it "should convert to propper time string format" do
      [Time.parse("2015-05-17 23:50:32"), "2015-05-17 23:50:32"].each do |datetime|
        expect( clean_time(datetime) ).to eq "23:50"
      end
    end

    it "should return nil for wrong datetime inputs" do
      ["abcd", 12345, "", nil].each do |datetime|
        expect( clean_time(datetime) ).to eq nil
      end
    end
  end
end
