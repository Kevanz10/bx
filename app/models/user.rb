class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_many :chats, :foreign_key => :sender_id

  has_many :donations
  has_many :requests
  before_save :set_saldo_zero
  
  def set_saldo_zero
    self.saldo ||= 0
  end
  
  
  def send_donation (value)
  
    #valor ultimas solicitudes
    pedi = { "uno": 100, "dos": 100, "tres": 100 , "cuatro": 200 }
    
    block = Request.where(status: "pending")
    
    block = block.order('created_at DESC').last(5)

    #valor entregado
    repartir = {"uno": 0, "dos": 0, "tres": 0, "cuatro": 0 }

    
    transaction_values = {"uno": 0, "dos": 0, "tres": 0, "cuatro": 0 }
    
    #stado del request
    estado = { "uno": false, "dos": false, "tres": false, "cuatro": false }

    saldo = 809
    
    donation_value = value

    porcentaje = pedi.values.min*20/100
    
    #Acá voy
   # percentages = 

    residuo = 0

    while (saldo > 0)
      if(saldo >= porcentaje)
        repartir.each{ |k, v|
          # no repartir mas del saldo que hay y para repartir no mas de lo que se pide
          if (saldo >= porcentaje && (pedi[k] >= repartir[k] + porcentaje))
            repartir[k] =  repartir[k] + porcentaje
            saldo = saldo - porcentaje
            p "EL SALDO ES #{saldo}"
            p "EL porcentaje es #{porcentaje}"
            p "Cuenta de usuario #{k}  tiene #{repartir[k]}"
          elsif (pedi[k] == repartir[k])
            p "entre acá"
            estado[k] = true
          end
          p "estados de la solicitudes #{estado}"

        }
        if (estado.values.all? {|x| x == true})
          residuo = saldo
          saldo = 0
        end
      else
        porcentaje = saldo/repartir.length.to_f
      end
    end


     p "distribucion es #{repartir}"
     p "residuo es #{residuo}"
     p "El saldo es #{saldo}"

  end
end
