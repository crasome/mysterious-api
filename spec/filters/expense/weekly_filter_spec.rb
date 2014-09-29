require "spec_helper"
require "active_support/all"

class Expense; end unless defined? Expense
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
    it "filters from the begining of the week til now" do
      range = double Range
      allow(subject).to receive(:week_range) { range }

      expect(relation).to receive(:where).with(time: range)
      subject.filter week: 1
    end
  end

  describe "week range" do
    before do
      time_now = Time.parse("Sep 29 2014 10:20:00")
      allow(Time).to receive(:now).and_return time_now
    end

    specify "last week" do
      beginig_of_last_week = Time.parse("Sep 22 2014 00:00:00")
      end_of_last_week = Time.parse("Sep 29 2014 00:00:00")

      last_week_range = subject.week_range 1

      expect(last_week_range.first).to eq beginig_of_last_week
      expect(last_week_range.last).to eq end_of_last_week
    end

    specify "this week" do
      beginig_of_this_week = Time.parse("Sep 29 2014 00:00:00")
      end_of_this_week = Time.parse("Oct 6 2014 00:00:00")

      last_week_range = subject.week_range 0

      expect(last_week_range.first).to eq beginig_of_this_week
      expect(last_week_range.last).to eq end_of_this_week
    end
  end
end
