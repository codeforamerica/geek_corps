$(function() { $('#flash .message.success, #flash .message.notice').delay(4000).hide('blind'); });

jQuery(document).ready(function() {
  $('.comment-body').hoverexpand({minHeight: "50px"});
});

function getUrlVars()
{
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}

/*
GeekCorps = {};
GeekCorps.Models = {};
GeekCorps.Views = {};
GeekCorps.Controllers = {};

GeekCorps.app = {
  init: function() {
    this.controller = new GeekCorps.Controllers.AppController();
  }
};

GeekCorps.Controllers.AppController = Backbone.Controller.extend({
  routes: {
    'sign_in': 'showSignInForm',
    'sign_in/:provider': 'showSignInForm'
  },
  initialize: function(options) {
    _.bindAll('showSignInForm', 'focusSearchField', this);
    if($('#global_sign_in').length > 0) {
      this.signInForm = new GeekCorps.Views.SignInForm({el: $('#global_sign_in')});
    }
    $(document).bind('keydown', '/', this.focusSearchField);
    $('input, textarea').placeholder();
  },
  showSignInForm: function(provider) {
    if(this.signInForm) {
      this.signInForm.toggleForm(true, provider);
    }
  },
  focusSearchField: function() {
    $('#global_search input').select();
    return false
  }
});

GeekCorps.Views.SignInForm = Backbone.View.extend({
  events: {
    'click  #sign_in_link': 'signInLinkClicked'
  },
  initialize: function(options) {
    _.bindAll('signInLinkClicked', 'toggleForm', this);

    this.formDiv = $('#global_sign_in_form');
    this.form = this.formDiv.find('form');
    this.emailInput = this.form.find('#sign_in_data_email');
    this.providerSelect = this.form.find('#sign_in_data_provider');
  },
  signInLinkClicked: function(e) {
    e.preventDefault();
    this.toggleForm();
  },
  toggleForm: function(show, provider) {
    if(typeof show != 'undefined') {
      $(this.el).add('#global_sign_in_form').toggleClass('open', show);
    } else {
      $(this.el).add('#global_sign_in_form').toggleClass('open');
    } 

    if($(this.el).hasClass('open')) { this.emailInput.focus(); }

    if(typeof provider != 'undefined') {
      this.providerSelect.val(provider);
    }
  }
});


$(function() { GeekCorps.app.init(); });
*/
