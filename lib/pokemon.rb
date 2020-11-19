require_relative "../bin/environment.rb"

class Pokemon
attr_accessor :name, :type, :db, :id
# @@db = SQLite3::Database.new("db/pokemon.db")


     def initialize(id:nil, name:, type:, db:)
          @name = name
          @type = type
          @db = db
          @id = id
     end

     def self.save(name, type, db)
          db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
          @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
      end

      def self.find(id_num, db)
          pokemon_info = db.execute("SELECT * FROM pokemon WHERE id=?", id_num).flatten
          Pokemon.new(id: pokemon_info[0], name: pokemon_info[1], type: pokemon_info[2], db: pokemon_info[3])
      end
      
     def self.update
          sql = "UPDATE pokemon SET name = ?, type = ?, db = ? WHERE id = ?"
          db.execute(sql, self.name, self.type, self.db, self.id)
     end

     def self.new_from_db(row)
          new_pokemon = Pokemon.new()    
          new_pokemon.id = row[0]
          new_pokemon.name =  row[1]
          new_pokemon.type = row[2]
          new_pokemon 
        end

end
