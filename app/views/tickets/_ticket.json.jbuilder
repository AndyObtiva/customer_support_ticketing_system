json.extract! ticket, :id, :support_request, :status, :closed_at, :customer_id, :support_agent_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)