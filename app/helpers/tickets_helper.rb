module TicketsHelper
  def ticket_filters
    raw(ticket_filter('open') + ' | ' + ticket_filter('closed') + ' | ' + ticket_filter('all'))
  end
  def ticket_filter(filter)
    filter_name = filter.titleize
    params[:filter] == filter ? filter_name : link_to(filter_name, tickets_path(filter: filter), id: "filter_by_#{filter}_tickets")
  end
end
