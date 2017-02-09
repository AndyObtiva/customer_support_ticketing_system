# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load.application", =>
  CommentsViewModel = =>
    this.comments = window.comments.map (comment, i) =>
      {
        created_at: comment.created_at,
        user_email: comment.user_email,
        body: comment.body
      }
    this.comments = ko.observableArray(this.comments)
    this.newComment = {
      ticket_id: ko.observable($('#comment_ticket_id').val()),
      user_id: ko.observable($('#comment_user_id').val()),
      user_email: ko.observable($('#comment_user_email').val()),
      created_at: ko.observable(new Date().toString()),
      body: ko.observable('New comment'),
      cssClass: 'comment in_progress'
    };
    setInterval((=> this.newComment.created_at(new Date().toString())), 1000)
    this.newComment.body.subscribe (newBody) =>
      if newBody.length > 0 && this.comments.indexOf(this.newComment) == -1
        this.comments.push(this.newComment)
    this.commentAction = (e) =>
      newCommentObject = {
        ticket_id: ko.observable(this.newComment.ticket_id()),
        user_id: ko.observable(this.newComment.user_id()),
        user_email: ko.observable(this.newComment.user_email()),
        created_at: ko.observable(this.newComment.created_at()),
        body: ko.observable(this.newComment.body()),
        cssClass: 'comment'
      }
      this.comments.pop()
      this.comments.remove(this.newComment)
      this.comments.push(newCommentObject)
      this.newComment.body('')
      comment = new CustomerSupportTicketingSystem.Models.Comment(
        ticket_id: newCommentObject.ticket_id(),
        user_id: newCommentObject.user_id(),
        created_at: newCommentObject.created_at(),
        body: newCommentObject.body()
      )
      comment.save()
      $('#comment_body').focus()
    $('#comment_body').on 'focus', (e) =>
      val = this.newComment.body()
      if val == 'New comment'
        this.newComment.body('')
  ko.applyBindings(new CommentsViewModel());
