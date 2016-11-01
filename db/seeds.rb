# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_or_create_by(email: 'foo@bar.com') do |u|
  u.uid = 'foo@bar.com'
  u.provider = 'email'
  u.password = 'foobar'
  u.first_name = 'Foo'
  u.last_name = 'Bar'
end

usjt      = Universidade.create(user: user , nome: 'Universidade São Judas Tadeu'                      , abreviacao: 'USJT'      , site: 'http://www.usjt.br')
fiap      = Universidade.create(user: user , nome: 'Faculdade de Informática e Administração Paulista' , abreviacao: 'FIAP'      , site: 'http://www.fiap.com.br')
fpca      = Universidade.create(user: user , nome: 'Faculdade Paulista Ciências Aplicadas'             , abreviacao: 'FPCA'      , site: 'http://www.fpca.com.br')
fappes    = Universidade.create(user: user , nome: 'Faculdade Paulista de Pesquisa e Ensino Superior'  , abreviacao: 'FAPPES'    , site: 'http://www.fappes.com.br')
fapss     = Universidade.create(user: user , nome: 'Faculdade Paulista de Serviço Social'              , abreviacao: 'FAPSS'     , site: 'http://www.fapss.com.br')
fapcom    = Universidade.create(user: user , nome: 'Faculdade Paulus de Tecnologia e Comunicação'      , abreviacao: 'FAPCOM'    , site: 'http://www.fapcom.com.br')
fipep     = Universidade.create(user: user , nome: 'Faculdade Práxis'                                  , abreviacao: 'FIPEP'     , site: 'http://www.fipep.com.br')
fasm      = Universidade.create(user: user , nome: 'Faculdade Santa Marcelina'                         , abreviacao: 'FASM'      , site: 'http://www.fasm.com.br')
mackenzie = Universidade.create(user: user , nome: 'Universidade Presbiteriana Mackenzie'              , abreviacao: 'Mackenzie' , site: 'http://www.mackenzie.com.br')

Unidade.create(universidade: usjt      , nome: 'Lasanha Valley'      , endereco: 'Rua Bolognous Avenue, 10'   , outras_informacoes: 'Take a ride!'        , unidade_sede: '1')
Unidade.create(universidade: fiap      , nome: 'lol'                 , endereco: 'Rua LOL, 6969'              , outras_informacoes: 'asdasd'              , unidade_sede: '1')
Unidade.create(universidade: fpca      , nome: 'Butantã'             , endereco: 'Rua Vital Brasil, 1000'     , outras_informacoes: 'nil'                 , unidade_sede: '0')
Unidade.create(universidade: fappes    , nome: 'Aclimação'           , endereco: 'Bairro Aclimação'           , outras_informacoes: nil                   , unidade_sede: '1')
Unidade.create(universidade: fapss     , nome: 'Higienópolis'        , endereco: 'Rua da Consolação'          , outras_informacoes: nil                   , unidade_sede: '1')
Unidade.create(universidade: fapcom    , nome: 'Alphaville'          , endereco: 'Bairro Alphaville'          , outras_informacoes: nil                   , unidade_sede: '0')
Unidade.create(universidade: fipep     , nome: 'Suspicious Mountain' , endereco: 'Rua Suspicious Road, 66'    , outras_informacoes: 'To Hell m/'          , unidade_sede: '1')
Unidade.create(universidade: fasm      , nome: 'São Paulo'           , endereco: 'Av. Prof. Almeida Prado'    , outras_informacoes: nil                   , unidade_sede: '0')
Unidade.create(universidade: mackenzie , nome: 'Sampa'               , endereco: 'Rua Sampa Mêmo'             , outras_informacoes: nil                   , unidade_sede: '0')
Unidade.create(universidade: usjt      , nome: 'Paulista'            , endereco: 'Av. Paulista, 1000'         , outras_informacoes: nil                   , unidade_sede: '0')
Unidade.create(universidade: fiap      , nome: 'Harry Potter'        , endereco: 'Rua Acathania'              , outras_informacoes: nil                   , unidade_sede: '0')
Unidade.create(universidade: fpca      , nome: 'Alguma unidade'      , endereco: 'Rua Alguma Coisa, 123'      , outras_informacoes: nil                   , unidade_sede: '0')
Unidade.create(universidade: fappes    , nome: 'São Paulo'           , endereco: 'Av. dos Bandeirantes, 2000' , outras_informacoes: 'Hello Informations.' , unidade_sede: '1')
