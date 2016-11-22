require 'sinatra'
require 'sinatra/bootstrap'
require 'sass/plugin/rack'
require 'pry'
require 'dotenv'
require 'pony'

Dotenv.load

register Sinatra::Bootstrap::Assets

get '/' do
  @page = 'index'

  erb :index
end

get '/contato' do
  @page = 'contact'

  erb :contact
end

get '/cidade' do
  @page = 'city'

  erb :city
end

get '/programacao' do
  @page = 'schedule'

  erb :schedule
end

get '/equipe' do
  @page = 'team'

  erb :team
end

get '/cidade' do
  @page = 'city'

  erb :city
end

get '/inscricoes' do
  @page = 'registrations'

  erb :registrations
end

get '/nova-inscricao' do
  @page = 'registrations'

  erb :registrations_new
end

post '/nova-inscricao' do
  @page = 'registrations'
  if params["abstract_file"].present?

    File.open('uploads/' + params["abstract_file"][:filename], "w") do |f|
      f.write(params["abstract_file"][:tempfile].read)
    end

    email_body = "Dados de Inscrição\n"\
                 "Modalidade: #{params['registration']['modality']}\n"\
                 "Data de inscrição: #{params['registration']['date']}\n"\
                 "\nDados Pessoais\n"\
                 "CPF: #{params['personal']['cpf']}\n"\
                 "RG: #{params['personal']['rg']}\n"\
                 "Naturalidade: #{params['personal']['nationality']}\n"\
                 "Nome: #{params['personal']['name']}\n"\
                 "Nome(crachá): #{params['personal']['badge_name']}\n"\
                 "Instituição(crachá): #{params['personal']['badge_institution']}\n"\
                 "\nFormação\n"\
                 "Titulação mais alta: #{params['formation']['titulation']}\n"\
                 "Curso de titulação: #{params['formation']['course']}\n"\
                 "Instituição de titulação: #{params['formation']['institution']}\n"\
                 "Ano de titulação: #{params['formation']['year']}\n"\
                 "\nAtuação Profissional\n"\
                 "Situação Profissional: #{params['professional']['situation']}\n"\
                 "Filiação institucional: #{params['professional']['filiation']}\n"\
                 "Função institucional/Cargo: #{params['professional']['function']}\n"\
                 "Áreas de atuação: #{params['professional']['areas']}\n"\
                 "\nEndereço\n"\
                 "Logradouro: #{params['address']['street']}\n"\
                 "Bairro: #{params['address']['neighborhood']}\n"\
                 "Município / UF: #{params['address']['uf']}\n"\
                 "CEP: #{params['address']['cep']}\n"\
                 "\nContato\n"\
                 "E-mail: #{params['contact']['email']}\n"\
                 "Telefone: #{params['contact']['phone']}\n"\
                 "Celular: #{params['contact']['mobile']}\n"\
                 "\nSubmeter trabalho\n"\
                 "Eixo temático: #{params['abstract']['theme']}\n"\
                 "Palavras-chave: #{params['abstract']['keywords']}"

    Pony.options = {
      :subject => "Nova inscrição!",
      :body => email_body,
      :attachments => {params["abstract_file"][:filename] => File.read("uploads/" + params['abstract_file'][:filename])},
      :via => :smtp,
      :via_options => {
        :address              => "smtp.gmail.com",
        :port                 => "465",
        :enable_starttls_auto => true,
	:ssl                  => true,
        :user_name            => ENV["SMTP_USER"],
        :password             => ENV["APP_PASSWORD"],
        :authentication       => :plain,
	:domain		      => "localhost.localdomain"
      }
    }

    Pony.mail(:to => "2pedro8@gmail.com; vitors.hirata@gmail.com")

    erb :registration_success
  else
    return 'Anexo vazio!'
  end
end
