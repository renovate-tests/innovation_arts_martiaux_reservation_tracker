require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = clients(:test_case)
  end

  test "should get index" do
    get clients_url
    assert_response :success
  end

  test "should get new" do
    get new_client_url
    assert_response :success
  end

  test "should create client if it has unique data" do
    assert_difference('Client.count') do
      post clients_url, params: {client: {id: 9999, email: 'some_unique_email@invalidemail.com', name: 'some unique name', telephone: '555-555-9999'}}
    end

    assert_redirected_to client_url(Client.last)
  end

  test "should not create client if name exists" do
    assert_difference 'Client.count', 0 do
      post clients_url, params: {client: {id: 9998, email: 'some_unique_email2@invalidemail.com', name: @client.name, telephone: '555-555-9998'}}
    end
    assert_response :success
  end


  test "should not create client if name is empty" do
    assert_difference 'Client.count', 0 do
      post clients_url, params: {client: {id: 9998, email: 'some_unique_email2@invalidemail.com', telephone: '555-555-9998'}}
    end
    assert_response :success
  end

  test "should not create client if telephone exists" do
    assert_difference 'Client.count', 0 do
      post clients_url, params: {client: {id: 9998, email: 'some_unique_email2@invalidemail.com', name: 'some_unique_name2', telephone: @client.telephone}}
    end
    assert_response :success
  end

  test "should not create client if telephone is empty" do
    assert_difference 'Client.count', 0 do
      post clients_url, params: {client: {id: 9998, email: 'some_unique_email2@invalidemail.com', name: 'some_unique_name2'}}
    end
    assert_response :success
  end

  test "should not create client if email exists" do
    assert_difference 'Client.count', 0 do
      post clients_url, params: {client: {id: 9998, email: @client.email, name: 'some_unique_name2', telephone: '555-555-9997'}}
    end
    assert_response :success
  end

  test "should not create client if email is empty" do
    assert_difference 'Client.count', 0 do
      post clients_url, params: {client: {id: 9998, name: 'some_unique_name2', telephone: '555-555-9997'}}
    end
    assert_response :success
  end

  test "should show client" do
    get client_url(@client)
    assert_response :success
  end

  test "should get edit" do
    get edit_client_url(@client)
    assert_response :success
  end

  test "should update client" do
    patch client_url(@client), params: {client: {id: @client.id, email: @client.email, name: @client.name, telephone: @client.telephone}}
    assert_redirected_to client_url(@client)
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete client_url(@client)
    end

    assert_redirected_to clients_url
  end
end
