class SupportAgent < User
  def default_ticket_filter
    'open'
  end
end
