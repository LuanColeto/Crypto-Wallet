namespace :dev do
  desc "Configura ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
        new_spin("Apagando DB...") { %x(rails db:drop) }
        new_spin("Criando DB...") { %x(rails db:create) }
        new_spin("Migrando DB...") { %x(rails db:migrate) }
        %x(rails dev:add_mining_type)
        %x(rails dev:add_coins)

    else
        puts "Você precisa estar em ambiente de desenvolvimento, você está em #{Rails.env}"
    end

  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    if Rails.env.development?
        new_spin("Cadastrando moedas...") do
        coins = [
            {
                description: "Bitcoin",
                acronym: "BTC",
                url_image: "data:image/png;base64,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",
                mining_type: MiningType.find_by(acronym: "PoW")
            },
            {
                description: "Dash",
                acronym: "Dash",
                url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSXbLW1WAfPqvPlKCL2C2OcH6t4mT80NS2c_B2cCDUj1AOFK0sU&usqp=CAU",
                mining_type: MiningType.find_by(acronym: "PoW")
            }
        ]


        coins.each do |coin|
            sleep(1)
            Coin.find_or_create_by!(coin)
        end
    end

    else
        puts "Você precisa estar em ambiente de desenvolvomento, você está em #{Rails.env}"
    end

  end

  desc "Cadastra tipos de mineração"
  task add_mining_type: :environment do
    if Rails.env.development?
        new_spin("Cadastrando tipos de mineração...") do
        minin_types = [
        {
            description: "Proof of Work",
            acronym: "PoW"
        },
        {
            description: "Proof of Stake",
            acronym: "PoS"
        },
        {
            description: "Proof of Concept",
            acronym: "PoC"
        }
    ]

    minin_types.each do |type|
        MiningType.find_or_create_by!(type)
    end
end

    else
        puts "Você precisa estar em ambiente de desenvolvimento, você está em #{Rails.env}"
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
