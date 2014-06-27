class CreateTableAcoes < ActiveRecord::Migration
  def change
    create_table(:acoes) do |t|
      t.string   :codigo,          null: false
      t.float    :valor_atual,     defulat: 0.0, null: false
      t.integer  :status,          default: 0, null: false
      t.datetime :locked_at

      t.timestamps
    end

    add_reference :acoes, :empresas, index: true

    add_index :acoes, :codigo, unique: true
  end
end
