class Expense::WeeklyFilter
  def initialize(relation)
    @relation = relation
  end

  def apply(params)
    relation
  end

  private
  attr_reader :relation
end
