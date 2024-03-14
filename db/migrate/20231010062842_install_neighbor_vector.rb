class InstallNeighborVector < ActiveRecord::Migration[7.0]
  def change
    if Rails.env.development? || Rails.env.test?
      enable_extension 'vector'
    end
  end
end
