class CreateTableEmpresas < ActiveRecord::Migration
  def change
    create_table(:empresas) do |t|
      t.string   :nome,          null: false
      t.string   :setor,         null: false
      t.string   :logo,          null: false
      t.integer  :status,        default: 0, null: false
      t.datetime :locked_at

      t.timestamps
    end

    add_index :empresas, :nome,   unique: true
    add_index :empresas, :status, unique: true
  end
end
