namespace :dev do
  desc "Configura ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
        new_spin("Apagando DB...") { %x(rails db:drop) }
        new_spin("Criando DB...") { %x(rails db:create) }
        new_spin("Migrando DB...") { %x(rails db:migrate) }
        new_spin("Populando DB...") {%x(rails db:seed)}

    else
        puts "Você precisa estar em ambiente de desenvolvimento, vocÊ está em #{Rails.env}"
    end

  end

  private

  def new_spin(start_message, end_message = "Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{start_message}")
    spinner.auto_spin
    yield
    spinner.success("(#{end_message})")
  end

end
