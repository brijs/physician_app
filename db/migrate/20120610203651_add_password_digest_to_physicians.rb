class AddPasswordDigestToPhysicians < ActiveRecord::Migration
  def change
    add_column :physicians, :password_digest, :string
  end
end
