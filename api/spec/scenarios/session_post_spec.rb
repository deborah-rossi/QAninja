# Don't Repeat Yourself => Não se repita

describe "POST /sessions" do
  context "login com sucesso" do
    before(:all) do
      payload = { email: "su@gmail.com", password: "debs123" }

      @result = Sessions.new.login(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuario" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  # examples = [
  #   {
  #     title: "Senha incorreta",
  #     payload: { email: "renato@gmail.com", password: "debs124" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "Usuario nao existe",
  #     payload: { email: "404@gmail.com", password: "debs123" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "E-mail em branco",
  #     payload: { email: "", password: "debs124" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "Sem o campo e-mail",
  #     payload: { password: "debs124" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "Senha em branco",
  #     payload: { email: "renato@gmail.com", password: "" },
  #     code: 412,
  #     error: "required password",
  #   },
  #   {
  #     title: "Sem o campo senha",
  #     payload: { email: "renato@gmail.com" },
  #     code: 412,
  #     error: "required password",
  #   },
  # ]

  examples = Helpers::get_fixture("login")

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Sessions.new.login(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida id do usuario" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
