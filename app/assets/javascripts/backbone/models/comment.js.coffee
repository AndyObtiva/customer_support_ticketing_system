class CustomerSupportTicketingSystem.Models.Comment extends Backbone.Model
  url: '/comments'
  paramRoot: 'comment'

  defaults:
    body: null
    ticket_id: null
    user_id: null
    created_at: null
    updated_at: null

class CustomerSupportTicketingSystem.Collections.CommentsCollection extends Backbone.Collection
  model: CustomerSupportTicketingSystem.Models.Comment
  url: '/comments'
