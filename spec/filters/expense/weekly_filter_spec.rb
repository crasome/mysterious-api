require "spec_helper"
require "active_support/all"

class Expense; end unless defined? Rails
require "filters/expense/weekly_filter"

describe Expense::WeeklyFilter do
  subject { described_class.new relation }
  let(:relation) { double :relation }

  describe "no arguments" do
    it "return unaltered relation" do
      expect(subject.filter).to eq relation
    end
  end

  describe "this week" do
    it "filters relation for week_range" do
      range = double Range
      allow(subject).to receive(:week_range) { range }

      expect(relation).to receive(:where).with(time: range)
      subject.filter week: 1
    end
  end

  describe "week range" do
    before do
      time_now = Time.parse("Sep 29 2014 10:20:00 UTC")
      allow(Time).to receive(:now).and_return time_now
    end

    specify "last week" do
      last_week_range = subject.week_range 1

      expect(last_week_range).to cover Time.parse("Sep 22 2014 00:00:00 UTC")
      expect(last_week_range).to cover Time.parse("Sep 22 2014 10:00:00 UTC")
      expect(last_week_range).to cover Time.parse("Sep 28 2014 23:00:00 UTC")

      expect(last_week_range).not_to cover Time.parse("Sep 8 2014 00:00:00 UTC")
      expect(last_week_range).not_to cover Time.parse("Sep 8 2014 10:00:00 UTC")
    end

    specify "this week" do
      this_week_range = subject.week_range 0

      expect(this_week_range).to cover Time.parse("Sep 29 2014 00:00:00 UTC")
      expect(this_week_range).to cover Time.parse("Sep 29 2014 10:00:00 UTC")
      expect(this_week_range).to cover Time.parse("Oct 5 2014 23:00:00 UTC")

      expect(this_week_range).not_to cover Time.parse("Oct 6 2014 00:00:00 UTC")
      expect(this_week_range).not_to cover Time.parse("Oct 6 2014 10:00:00 UTC")
    end
  end
end
