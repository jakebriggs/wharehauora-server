class AddGatewayMacToHome < ActiveRecord::Migration
  def change
    add_column :homes, :gateway_mac_address, :string
  end
end
