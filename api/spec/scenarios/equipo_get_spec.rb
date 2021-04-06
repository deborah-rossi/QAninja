describe "GET /equipos/{equipo_id}" do
  before(:all) do
    payload = { email: "debo@gmail.com", password: "debs123" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "obter unico equipo" do
    before(:all) do
      # dado que eu tenha um unico equipamento
      @payload = {
        thumbnail: Helpers::get_thumb("sanfona.jpg"),
        name: "Sanfona",
        category: "Outros",
        price: 499,
      }

      MongoDB.new.remove_equipo(@payload[:name], @user_id)

      # e eu tenho o id desse equipamento
      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      # quando faço uma requisiçao GET por id
      @result = Equipos.new.find_by_id(@equipo_id, @user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end

    it "deve retornar o nome" do
      expect(@result.parsed_response).to include("name" => @payload[:name])
    end
  end

  context "equipo nao existe" do
    before(:all) do
      @result = Equipos.new.find_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it "deve retornar 404" do
      expect(@result.code).to eql 404
    end
  end
end

describe "GET /equipos" do
  before(:all) do
    payload = { email: "zinho@gmail.com", password: "debs123" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]

    context "obter uma lista" do
      # dado que eu tenho uma lista de quipos
      before(:all) do
        payloads = [
          {
            thumbnail: Helpers::get_thumb("sanfona.jpg"),
            name: "Sanfona",
            category: "Outros",
            price: 499,
          },
          {
            thumbnail: Helpers::get_thumb("trompete.jpg"),
            name: "Trompete",
            category: "Outros",
            price: 599,
          },
          {
            thumbnail: Helpers::get_thumb("slash.jpg"),
            name: "Les paul",
            category: "Cordas",
            price: 699,
          },
        ]

        payloads.each do |payload|
          MongoDB.new.remove_equipo(payload[:name], @user_id)
          Equipos.new.create(payload, @user_id)
        end

        # quando faço uma requisiçao GET para /equipos
        @result = Equipos.new.list(@user_id)
      end

      it "deve retornar 200" do
        expect(@result.code).to eql 200
      end

      it "deve retornar uma lista de equipos" do
        expect(@result.parsed_response).not_to be_empty
      end
    end
  end
end
