require_relative 'spec_helper.rb'

class ExtensionsTest < MiniTest::Spec
  include Rack::Test::Methods

  register_spec_type(/.+$/, self)

  def app
    SassMeisterApp
  end

  describe "Routes" do
    describe "GET /" do
      before do
        # using the rack::test:methods, call into the sinatra app and request the following url
        get "/"
      end

      it "responds not found" do
        # Ensure the request we just made gives us a  status code
        last_response.status.must_equal 404
      end
    end

    describe "GET /extensions" do
      before do
        get "/extensions"
      end

      it "responds with extension list HTML" do
        file = File.read(File.join(app.settings.public_folder, 'extensions.html')).to_s
        assert_equal file, last_response.body
      end
    end
  end
end
