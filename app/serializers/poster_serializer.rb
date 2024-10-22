class PosterSerializer
    def self.format_posters(posters)
        posters.map do |poster| {
            id: poster.id,
           #fix this type: poster.type,
            attributes: {
                name: poster.name,
                description: poster.description,
                price: poster.price,
                year: poster.year,
                vintage: poster.vintage,
              #also not right keyword  img_url: poster.src
            }
        }
        end
    end
end