class ApiV1OrdersTest < ActionDispatch::IntegrationTest

  test "try send integration" do
    post 'https://delivery-center-recruitment-ap.herokuapp.com/', {
        "externalCode": "9987071",
        "storeId": 282,
        "subTotal": "49.90",
        "deliveryFee": "5.14",
        "total_shipping": 5.14,
        "total": "61.90",
        "country": "BR",
        "state": "SP",
        "city": "Cidade de Testes",
        "district": "Bairro Fake",
        "street": "Rua de Testes Fake",
        "complement": "galpao",
        "latitude": -23.629037,
        "longitude":  -46.712689,
        "dtOrderCreate": "2019-06-27T19:59:08.251Z",
        "postalCode": "85045020",
        "number": "0",
        "customer": {
            "externalCode": "136226073",
            "name": "JOHN DOE",
            "email": "john@doe.com",
            "contact": "41999999999"
        },
        "items": [
            {
                "externalCode": "IT4801901403",
                "name": "Produto de Testes",
                "price": 49.9,
                "quantity": 1,
                "total": 49.9,
                "subItems": []
            }
        ],
        "payments": [
            {
                "type": "CREDIT_CARD",
                "value": 55.04
            }
        ]
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
