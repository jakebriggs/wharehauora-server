class DeleteInvitations < ActiveRecord::Migration
  def change
    drop_table :invitations
  end
end