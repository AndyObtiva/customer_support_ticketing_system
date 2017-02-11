# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load.application", =>
  CommentsViewModel = =>
    this.comments = window.comments.map (comment, i) =>
      commentCssClass = 'comment'
      commentCssClass += if comment.user_role == 'Customer' then ' initiating_message' else ' target_message'
      email_suffix = if comment.user_role == 'Customer' then ' (Customer)' else ' (Support Agent)'
      comment_user_email = comment.user_email + email_suffix
      {
        created_at: comment.created_at,
        user_email: comment_user_email,
        user_role: comment.user_role,
        body: comment.body,
        cssClass: commentCssClass
      }
    this.comments = ko.observableArray(this.comments)
    this.newComment = {
      ticket_id: ko.observable($('#comment_ticket_id').val()),
      user_id: ko.observable($('#comment_user_id').val()),
      user_email: ko.observable($('#comment_user_email').val()),
      user_role: ko.observable($('#comment_user_role').val()),
      created_at: ko.observable(new Date().toString()),
      body: ko.observable(''),
      cssClass: 'comment in_progress'
    };
    email_suffix = if this.newComment.user_role() == 'Customer' then ' (Customer)' else ' (Support Agent)'
    this.newComment.user_email(this.newComment.user_email() + email_suffix)
    this.newComment.cssClass += if this.newComment.user_role == 'Customer' then ' initiating_message' else ' target_message'

    setInterval((=> this.newComment.created_at(new Date().toString())), 1000)
    this.newComment.body.subscribe (newBody) =>
      if newBody.length > 0 && this.comments.indexOf(this.newComment) == -1
        this.comments.push(this.newComment)
    this.commentAction = (e) =>
      newCommentObject = {
        ticket_id: ko.observable(this.newComment.ticket_id()),
        user_id: ko.observable(this.newComment.user_id()),
        user_email: ko.observable(this.newComment.user_email()),
        user_role: ko.observable(this.newComment.user_role()),
        created_at: ko.observable(this.newComment.created_at()),
        body: ko.observable(this.newComment.body()),
        cssClass: ko.observable(this.newComment.cssClass.replace('in_progress', ''))
      }
      this.comments.pop()
      this.comments.push(newCommentObject)
      comment = new CustomerSupportTicketingSystem.Models.Comment(
        ticket_id: newCommentObject.ticket_id(),
        user_id: newCommentObject.user_id(),
        created_at: newCommentObject.created_at(),
        body: newCommentObject.body()
      )
      comment.save()
      $('#comment_body').focus()
      this.newComment.body('')
    $('#comment_body').on 'keyup', (event) =>
      val = this.newComment.body()
      if val == '' && (event.keyCode == 8 || event.keyCode == 46)
        this.comments.pop()
  ko.applyBindings(CommentsViewModel());
