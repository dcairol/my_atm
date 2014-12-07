// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var MY_APP = MY_APP || {};

jQuery(function($){

  MY_APP.ATM = (function(){

    var amount_field = $('#amount'),
      current_funds = $('#current_funds'),
      form = $('#withdraw form'),
      success_message = $('#success_message'),
      error_message = $('#error_message'),
      message_duration = 5 * 1000,
      display_success_message,
      display_error,
      on_withdraw_success;

    display_error = function(error){
      error_message.html('<p>The following error has been encountered: ' + error + '.</p>');
      error_message.fadeIn(500, function(){
        error_message.fadeOut(message_duration);
      })
    };

    display_success_message = function(dispensed){
      success_message.html('<p>' + dispensed + ' have been successfully dispensed.</p>');
      success_message.fadeIn(500, function(){
        success_message.fadeOut(message_duration);
      });
    };

    on_withdraw_success = function(data){
      current_funds.text(data.new_balance);
      display_success_message(data.dispensed);
    };

    amount_field.on('keydown', function(e){
      var key_code = e.which;
      if($.inArray(key_code, [46, 8, 9, 27, 13, 110, 190]) !== -1 || (key_code >= 48 && key_code <= 57) ){
        return;
      }else{
        e.preventDefault();
      }
    });

    form
      .on('ajax:success', function(jqXHR, data, status){
        if(data.error){
          display_error(data.message);
        }else if(data.success){
          on_withdraw_success(data)
        }
      })
      .on('ajax:error', function(jqXHR, data, status){

      });

  }());
});