class Order < ActiveRecord::Base
	belongs_to :store
	belongs_to :shipping
	belongs_to :buyer

	has_many :order_items, auto_save: true, :dependent => :destroy
	has_many :payments, auto_save: true, :dependent => :destroy

	validates :store_id, presence: true
	validates :date_created, presence: true
	validates :date_closed, presence: true
	validates :last_updated, presence: true
	validates :total_amount, presence: true
	validates :total_shipping, presence: true
	validates :total_amount_with_shipping, presence: true
	validates :paid_amount, presence: true
	validates :last_updated, presence: true
	validates :status, presence: true #Aqui eu via a necessidade de uma model statica, por ser status
	validates :shipping_id, presence: true
	validates :buyer_id, presence: true

	after_save :do_integration

	# Realizo a integração (API REST POST) somente no after_save, após passar pelas validações
	def do_integration
		items = []
		payments = []

		self.order_items.each do |order_item|
			items << {
				"externalCode": order_item.try(:item).try(:id),
	            "name": order_item.try(:item).try(:title),
	            "price": order_item.unit_price,
	            "quantity": order_item.quantity,
	            "total": order_item.full_unit_price,
	            "subItems": []
			}
		end

		self.payments.each do |payment|
			payments << {
				"type": payment.payment_type.upcase,
            	"value": payment.value
			}
		end

		post 'https://delivery-center-recruitment-ap.herokuapp.com/', {
	      	"externalCode": self.id.to_s,
		    "storeId": self.store_id,
		    "subTotal": self.total_amount,
		    "deliveryFee": self.total_shipping.to_s,
		    "total_shipping": self.total_shipping,
		    "total": (self.total_amount + self.total_shipping).to_s,
		    "country": self.shipping.try(:receiver_address).try(:country).try(:id),
		    "state": self.shipping.try(:receiver_address).try(:state).try(:id),
		    "city": self.shipping.try(:receiver_address).try(:city).try(:name),
		    "district": elf.shipping.try(:receiver_address).try(:neighborhood).try(:name),
		    "street": self.shipping.try(:receiver_address).try(:street_name),
		    "complement": self.shipping.try(:receiver_address).try(:comment),
		    "latitude": self.shipping.try(:receiver_address).try(:latitude),
		    "longitude":  self.shipping.try(:receiver_address).try(:longitude),
		    "dtOrderCreate": self.date_created.to_s,
		    "postalCode": self.shipping.try(:receiver_address).try(:zipcode),
		    "number": self.shipping.try(:receiver_address).try(:street_number),
		    "customer": {
		        "externalCode": self.try(:buyer).try(:id).to_s,
		        "name": self.try(:buyer).try(:nickname),
		        "email": self.try(:buyer).try(:email),
		        "contact": ((self.phone.present? && self.phone.area_code.present?) ? self.phone.area_code.to_s + self.phone.try(:number) : self.phone.try(:number))
		    },
		    "items": items,
		    "payments": payments
	    }.to_json, {
	      "Accept" => "application/json",
	      "Content-Type" => "application/json",
	      "Authorization" => "Token token=user_token",
	      "X-Language" => 'pt_BR',
	      "X-Sent" => '09h25 - 24/10/19'
	    }

	    # O que tem retorno, eu recebo aqui (sucesso ou erro)
	    @body = JSON.parse(response.body)
	end
end
