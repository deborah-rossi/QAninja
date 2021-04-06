describe "POST /equipos/{equipos_id}/bookings" do
  before(:all) do
    payload = { email: "aline@gmail.com", password: "debs123" }
    result = Sessions.new.login(payload)
    @aline_id = result.parsed_response["_id"]
  end

  context "solicitar locacao" do
    before(:all) do

      # dado que "Renato" tem um equipamento para locação
      result = Sessions.new.login({ email: "renato@gmail.com", password: "debs123" })
      renato_id = result.parsed_response["_id"]

      fender = {
        thumbnail: Helpers::get_thumb("fender-sb.jpg"),
        name: "Fernder Strato",
        category: "Cordas",
        price: 150,
      }
      MongoDB.new.remove_equipo(fender[:name], renato_id)

      result = Equipos.new.create(fender, renato_id)
      fender_id = result.parsed_response["_id"]

      # quando solicito a locaçao da Fender do Zinho

      @result = Equipos.new.booking(fender_id, @aline_id)
    end
    it "Deve retornar 200" do
      expect(@result.code).to eql 200
    end
  end
end
