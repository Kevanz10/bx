class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_many :donations
  has_many :requests
  before_save :set_saldo_zero
  
  def set_saldo_zero
    self.saldo ||= 0
  end
  
  
  def send_donation (value)
  
    
    #Configuración de variables para inicializar la donación
  
    request = get_oldest_request() #Tomar el request mas antiguo

    donation_value = value.round() #valor de la donacion ingresada  
    
    residuo = donation_value #valor pendiente por entregar de la donación, campo pending de la donación

    donation_state = 0  #estado de la donación, si ya ha sido repartida o aun no. 
    
    donation = self.donations.create(value: donation_value, pending: residuo, status: donation_state)
    
    #revisar resultados del metodo mientras haya residuo y la cola se puede actualziar con transacciones pendientes volver a repartir

    while((donation.pending > 0) && request )

        create_transaction(request, donation) 
        #Funcion para realizar el envio con las variables configuradas
        request = get_oldest_request() #Tomar el request mas antiguo
  
    end

    #imprimir valores en los que se repartio la donación
=begin
    p "para request #{i}"
    p "El usuario que solicito la transacction en el bloque #{i}  es #{block[i].user_id}"
    p "El usuario que recibirá la transaccon #{i}  es #{donation.transactions[i].receiver_id}"
    p "El valor solicitado en el bloque #{i}  es #{block[i].value}"
    p "El valor a consignar #{i}  es #{donation.transactions[i].value}" 
    p "El valor pendiente por consignar en #{i}  es #{block[i].pending}" 
    p "El residuo de la donación es  #{residuo}"
=end 
  #method end
  end
  
  
  def create_transaction(request, donation)

    #repartir la donación en el request
    #Inicializar valores para calcular la transacción
    #valor a entregar por transacción 
    transaction_value = 0
    #estado del  request
    request_state = 0

    if request.pending > donation.pending || request.pending == donation.pending

       transaction_value = donation.pending
       residuo = 0

    elsif request.pending < donation.pending

       transaction_value = request.pending
       residuo = donation.pending - transaction_value
       
    end

    #crear la transacción
    transaction = donation.transactions.create(value: transaction_value, sender_id: donation.user_id, receiver_id: request.user_id, request_id: request.id)
   
    #hacer update de la donación
    #Actualizar estado de la donacion 
    if residuo==0
      donation_state = 1
    end

    donation.update(pending: residuo, status: donation_state)

    #actualizar valores  del request  
    request.pending = request.pending - transaction_value

    if request.pending == 0 
      request_state = 1
    end

    request.update(pending: request.pending - transaction_value, requested: request_state)

    
  end
        
  def get_oldest_request
    
    block = Request.where.not(user_id: self.id)
    block = block.where(requested: "waiting")
    block.order('created_at DESC').last()

  end
  

end
    



