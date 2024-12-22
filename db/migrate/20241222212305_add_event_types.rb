class AddEventTypes < ActiveRecord::Migration[6.1]
  def up
    EventType.create([{ name: 'Infantil'},
                      { name: 'Casamento' },
                      { name: 'Debutante' },
                      { name: 'Coffee break' },
                      { name: 'Aniversario' },
                      { name: 'Aluguel espaço' },
                      { name: 'Outros'}])
  end

  def down
    EventType.delete_all
  end
end
