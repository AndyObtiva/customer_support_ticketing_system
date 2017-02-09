class SupportAgent < User
  def default_ticket_query_filter
    {status: 'open'}
  end
end
