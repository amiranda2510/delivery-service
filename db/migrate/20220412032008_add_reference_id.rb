class AddReferenceId < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :reference_id, :string
    add_column :bookings, :payload, :json
  end
end
