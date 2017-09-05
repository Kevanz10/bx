App.messages = App.cable.subscriptions.create('MessagesChannel', {  
  received: function(data) {
    $("#messages").removeClass('hidden')
    return $('#messages').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
  	debugger;
    return "<strong>" + data.user + "</strong>" + " " + data.time + "<br>" + data.message + "<br>";
  }
});