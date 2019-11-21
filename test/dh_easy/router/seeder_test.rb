require 'test_helper'

describe 'seeder' do
  describe 'unit test' do
    before do
      @context = Object.new
      @config = DhEasy::Config::Local.new file_path: './test/input/config.yaml'
      @router = DhEasy::Router::Seeder.new config: @config
    end

    it 'should raise error on route when no context' do
      assert_raises(ArgumentError, 'Must send a context to the seeder.') do
        @router.route
      end
    end

    it 'should raise error on route when class doesn\'t exists' do
      router = DhEasy::Router::Seeder.new config_file_path: './test/input/config_bad.yaml'
      assert_raises(NameError, "Class \"GHIJK\" doesn't exists, check your dh_easy config file.") do
        router.route context: @context
      end
    end

    it 'should route to all seeders' do
      DhEasy::Router::Test::SeederBase.mock_clear_data
      @router.route context: @context
      data = DhEasy::Router::Test::SeederBase.mock_data
      expected = {
        init_opts: {
          context: @context
        },
        seed: true
      }
      assert_equal expected, data['DhEasy::Router::Test::SeederA']
      assert_equal expected, data['DhEasy::Router::Test::SeederB']
    end
  end
end
