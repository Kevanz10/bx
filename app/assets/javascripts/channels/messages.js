App.messages = App.cable.subscriptions.create('MessagesChannel', {  
  received: function(data) {
    $("#messages").removeClass('hidden');
		return $('#messages').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
  	debugger;
  	if (data.text!==undefined) {
  		swal('Recuerde que solo puede enviar un mensaje hasta que el equipo de soporte se comunique con usted.');
  	}else{
    	return "<strong>" + data.user + "</strong>" + " " + data.time + "<br>" + data.message + "<br>" ;
  	}
  }
});

// if (data.admin === true) {
// 			if (data.current_user_admin === false) {
// 				debugger;
// 				if (data.count === 0) {
// 	      	$('.enviar-chat').prop('disabled', false);
// 	      } else if(data.count == 1){
// 	      	swal('Recuerde que solo puede enviar un mensaje hasta que el equipo de soporte se comunique con usted.');
// 	         $('.enviar-chat').prop('disabled', true);
// 	      }	else{
// 	      	$('.enviar-chat').prop('disabled', false);
// 	      }
// 			}
// 		}