require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  let!(:user) do
    User.create!(
      name: "テスト太郎",
      email: "test@example.com",
      password: "password"
    )
  end

  describe "POST /api/v1/login" do
    context "正しい情報を送ったとき" do
      it "ログインに成功してユーザー情報が返る" do
        post "/api/v1/login", params: { email: user.email, password: "password" }

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json["user"]["email"]).to eq(user.email)
        expect(json["user"]["name"]).to eq("テスト太郎")
      end
    end

    context "誤ったパスワードを送ったとき" do
      it "ログインに失敗して401が返る" do
        post "/api/v1/login", params: { email: user.email, password: "wrong_password" }

        expect(response).to have_http_status(:unauthorized)

        json = JSON.parse(response.body)
        expect(json["message"]).to eq("メールアドレスまたはパスワードが違います")
      end
    end

    context "誤ったメールアドレスとパスワードを送ったとき" do
      it "ログインに失敗して401が返る" do
        post "/api/v1/login", params: { email: "wrong@example.com", password: "wrong_password" }

        expect(response).to have_http_status(:unauthorized)

        json = JSON.parse(response.body)
        expect(json["message"]).to eq("メールアドレスまたはパスワードが違います")
      end
    end
  end
end
