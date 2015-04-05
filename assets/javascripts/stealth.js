jQuery(function($) {
  window.RedmineStealth = {
    cloak: function(label) {
      $('#stealth_toggle').text(label).
        data({ params : { toggle : 'false' } });
      $('body').toggleClass('stealth', true);
    },

    decloak: function(label) {
      $('#stealth_toggle').text(label).
        data({ params : { toggle : 'true' } });
      $('body').toggleClass('stealth', false);
    },

    notifyFailure: function() {
      alert($('#stealth_toggle').data('failure-message'));
    }
  };

  $('#stealth_toggle').bind('ajax:error', RedmineStealth.notifyFailure);
});
