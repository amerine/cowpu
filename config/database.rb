##
# A MySQL connection:
# DataMapper.setup(:default, 'mysql://user:password@localhost/the_database_name')
#
# # A Postgres connection:
# DataMapper.setup(:default, 'postgres://user:password@localhost/the_database_name')
#

DataMapper.logger = logger

postgres = URI.parse(ENV['DATABASE_URL'] || '')

case Padrino.env
  when :development then DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "development.db"))
  when :production  then DataMapper.setup(:default, "postgres://#{postgres.user}:#{postgres.password}@#{postgres.host}/#{postgres.user}")
  when :test        then DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "test.db"))
end
