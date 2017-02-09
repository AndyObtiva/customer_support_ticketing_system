class LastOneMonthClosedTicketsReport < Report
  def generate_report
    today = Date.today.to_datetime.end_of_day
    same_day_last_month = (today - 1.month).beginning_of_day
    self.tickets = Ticket.closed.where(closed_at: same_day_last_month..today)
  end
end
