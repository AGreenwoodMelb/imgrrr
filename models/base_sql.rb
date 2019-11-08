require 'pg'

def run_sql (sql)
    conn = PG.connect(ENV['DATABASE_URL'] || {dbname: 'imgrrrdb'})
    toReturn = conn.exec(sql)
    conn.close()
    return toReturn
end
