class Expense::NameFilter
  def initialize(relation)
    @relation = relation
  end

  def filter(params = {})
    name = params.fetch :description
    relation.where relation.arel_table[:description].matches("%#{name}%")
  rescue KeyError
    relation
  end

  private
  attr_reader :relation
end
