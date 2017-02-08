class SupportAgent < User
  def tickets
    Ticket.open
  end
end
