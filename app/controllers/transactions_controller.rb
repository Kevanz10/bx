class TransactionsController < ApplicationController
    
    def add_invoice
        @transaction = Transaction.find(params[:transaction_id])
        @transaction.invoice = params[:invoice]
        @transaction.save!
        raise
        redirect_to '/my_dashboard', notice: "image succesfully saved"
    end

private
    def invoice_params
      params.permit(:invoice)
    end

end
