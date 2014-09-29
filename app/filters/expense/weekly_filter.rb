class Expense::WeeklyFilter
  def initialize(relation)
    @relation = relation
  end

  def filter(params = {})
    week_no = params.fetch :week
    relation.where time: week_range(week_no)
  rescue KeyError
    relation
  end

  def week_range(week_no)
    period = week_no >= 1 ? (week_no - 1) : -1
    week_no.weeks.ago.at_beginning_of_week..period.weeks.ago.at_beginning_of_week
  end

  private
  attr_reader :relation
end
