require 'test_helper'

class PlexAuthTest < Minitest::Test
  def setup
    @pin_response = {
      'id'        => '12345',
      'code'      => 'ABCD',
      'expiresAt' => (Time.now + 300).utc.iso8601,
      'authToken' => nil
    }

    @validated_response = @pin_response.merge('authToken' => 'valid-token')

    @server_response = [{
      'name'             => 'My Plex Server',
      'product'          => 'Plex Media Server',
      'clientIdentifier' => 'unique-identifier',
      'provides'         => 'server',
      'publicAddress'    => '127.0.0.1',
      'accessToken'      => 'access-token',
      'httpsRequired'    => false,
      'connections'      => [{
        'address'  => '192.168.1.100',
        'port'     => 32400,
        'uri'      => 'http://192.168.1.100:32400',
        'protocol' => 'http'
      }]
    }]
  end

  def test_request_pin
    stub_request(:post, Plex::Auth::NEW_PIN_URL)
      .with(
        headers: Plex::Auth::HEADERS,
        query: { strong: false }
      )
      .to_return(
        status: 201,
        body: @pin_response.to_json
      )

    response = Plex::Auth.request_pin
    assert_equal @pin_response, response
  end

  # validate_pin

  # test validate_pin_when_no_token_exists
  def test_validate_pin_when_no_token_exists
    pin_id = @pin_response['id']
    url = format(Plex::Auth::VALIDATE_PIN_URL, pin_id: pin_id)

    response_without_token = @pin_response.merge('authToken' => nil)

    stub_request(:get, url)
      .with(headers: Plex::Auth::HEADERS)
      .to_return(
        status: 200,
        body: response_without_token.to_json
      )

    result = Plex::Auth.validate_pin(@pin_response)
    assert_nil result['authToken']
  end

  def test_validate_pin
    pin_id = @pin_response['id']
    url = format(Plex::Auth::VALIDATE_PIN_URL, pin_id: pin_id)

    stub_request(:get, url)
      .with(headers: Plex::Auth::HEADERS)
      .to_return(
        status: 200,
        body: @validated_response.to_json
      )

    result = Plex::Auth.validate_pin(@pin_response)
    assert_equal 'valid-token', result['authToken']
  end

  def test_validate_expired_pin
    expired_response = @pin_response.merge(
      'expiresAt' => (Time.now - 300).utc.iso8601  # 5 minutes ago
    )

    pin_id = expired_response['id']
    url = format(Plex::Auth::VALIDATE_PIN_URL, pin_id: pin_id)

    stub_request(:get, url)
      .with(headers: Plex::Auth::HEADERS)
      .to_return(
        status: 200,
        body: expired_response.to_json
      )

    result = Plex::Auth.validate_pin(expired_response)
    assert_nil result['authToken']
    assert Time.now > Time.new(result['expiresAt'])
  end

  # get_servers

  def test_get_servers
    stub_request(:get, Plex::Auth::SERVERS_URL)
      .with(
        headers: Plex::Auth::HEADERS.merge('X-Plex-Token' => 'valid-token'),
        query: { 'includesHttps' => 1 }
      )
      .to_return(
        status: 200,
        body: @server_response.to_json
      )

    connections = Plex::Auth.get_servers(token: 'valid-token')
    assert_equal 1, connections.length

    connection = connections.first
    assert_equal '192.168.1.100', connection['address']
    assert_equal 32400, connection['port']
    assert_equal 'access-token', connection['accessToken']
  end

  # get_server_settings

  def test_get_server_settings_has_required_parameters
    stub_request(:get, Plex::Auth::SERVERS_URL)
      .with(
        headers: Plex::Auth::HEADERS.merge('X-Plex-Token' => 'valid-token'),
        query: { 'includesHttps' => 1 }
      )
      .to_return(
        status: 200,
        body: @server_response.to_json
      )

    settings = Plex::Auth.get_server_settings(token: 'valid-token')
    assert_equal 1, settings.length

    server = settings.first
    assert_equal '192.168.1.100', server[:plex_host]
    assert_equal 32400, server[:plex_port]
    assert_equal 'access-token', server[:plex_token]
    refute server[:ssl]
  end
end
