namespace :dev do
  desc "TODO"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate)} 
      %x(rails dev:populate)
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end

  end

  desc "TODO"
  task populate: :environment do

    
    show_spinner("Cadastrando Tipos de Eventos...") do
      eventType = [{name: "Caminhada"},{name: "Corrida"},{name: "Bicicleta"},{name: "Futebol"}]
      eventType.each do |eventType|
        EventType.find_or_create_by!(eventType)
      end
    end
  end


  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")    
  end
end
