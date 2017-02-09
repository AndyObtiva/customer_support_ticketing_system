# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load.application", =>
  CommentsViewModel = =>
    this.comments = window.comments.map (comment, i) =>
      {
        createdAt: comment.created_at,
        userEmail: comment.user_email,
        body: comment.body
      }
    this.comments = ko.observableArray(this.comments)
    this.newComment = {
      userEmail: ko.observable($('#ticket_user_email').val()),
      createdAt: ko.observable(new Date().toString()),
      body: ko.observable('New comment'),
      cssClass: 'comment in_progress'
    };
    setInterval((=> this.newComment.createdAt(new Date().toString())), 1000)
    this.newComment.body.subscribe (newBody) =>
      if newBody.length > 0 && this.comments.indexOf(this.newComment) == -1
        this.comments.push(this.newComment)
    this.commentAction = (e) =>
      newCommentObject = {
        userEmail: ko.observable(this.newComment.userEmail()),
        createdAt: ko.observable(this.newComment.createdAt()),
        body: ko.observable(this.newComment.body()),
        cssClass: 'comment'
      }
      this.comments.pop()
      this.comments.remove(this.newComment)
      this.comments.push(newCommentObject)
      this.newComment.body('')
      $('#comment_body').focus()
    $('#comment_body').on 'focus', (e) =>
      val = this.newComment.body()
      if val == 'New comment'
        this.newComment.body('')
  ko.applyBindings(new CommentsViewModel());
