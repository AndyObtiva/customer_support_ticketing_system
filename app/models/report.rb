class Report
  include ActiveModel::Model
  include AbstractType

  attr_accessor :tickets, :generated_at

  def name
    self.class.name.titleize
  end

  def generate
    generate_report
    timestamp_generation
    self
  end

  protected
  abstract_method :generate_report
  def timestamp_generation
    self.generated_at = DateTime.current
  end
end
