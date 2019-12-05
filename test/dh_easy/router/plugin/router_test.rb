require 'test_helper'

describe 'plugin router' do
  before do
    @object = Object.new
    class << @object
      include DhEasy::Router::Plugin::Router
    end
    @expected_orig = {
      'aaa' => 111,
      'router' => {
        'parser' => {
          'routes' => [
            {
              'page_type' => 'type_a',
              'class' => 'DhEasy::Router::Test::ParserA'
            },
            {
              'page_type' => 'type_b',
              'class' => 'DhEasy::Router::Test::ParserB'
            }
          ]
        },
        'seeder' => {
          'routes' => [
            {'class' => 'DhEasy::Router::Test::SeederA'},
            {'class' => 'DhEasy::Router::Test::SeederB'}
          ]
        },
        'finisher' => {
          'routes' => [
            {'class' => 'DhEasy::Router::Test::FinisherA'},
            {'class' => 'DhEasy::Router::Test::FinisherB'}
          ]
        }
      },
      'bbb' => 222
    }
  end

  describe 'unit test' do
    it 'should validate when a class is defined' do
      refute @object.class_defined?('ABCDE')
      assert @object.class_defined?('DhEasy::Router::Test::ParserA')
    end

    it 'should get a class by name' do
      data = @object.get_class 'DhEasy::Router::Test::ParserA'
      assert_equal DhEasy::Router::Test::ParserA, data
    end

    it 'should give null when get an unexisting class by name' do
      data = @object.get_class 'ABCDE'
      assert_nil data
    end

    it 'should initialize with config object' do
      config = DhEasy::Config::Local.new file_path: './test/input/config.yaml'
      @object.initialize_hook_router_plugin_router config: config
      assert_equal @expected_orig, @object.local_config.local
      refute_nil config
      assert_equal config, @object.local_config
    end

    it 'should initialize with config file' do
      config = DhEasy::Config::Local.new file_path: './test/input/config.yaml'
      @object.initialize_hook_router_plugin_router config: config
      assert_equal @expected_orig['router'], @object.config
    end
  end
end
