require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  all_characters = []

  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  

  all_characters << response_hash["results"]

  loop do
    
    if response_hash["next"] == nil
      break
    else
      page = response_hash["next"]
      response_string = RestClient.get(page)
      response_hash = JSON.parse(response_string)
      all_characters << response_hash["results"]
    end
  end

  all_characters = all_characters.flatten

  character_hash = all_characters.find {|character| character["name"] == character_name}

  
  if character_hash == nil
    return "That character does not exist, Trekkie."
  end
  
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  film_array = character_hash["films"]
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  character_films = film_array.collect do |film|
    film_response = RestClient.get(film)
    JSON.parse(film_response)
  end
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film

  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  
  character_films
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.collect {|film| film["title"]}
end

def show_character_movies(character)
  character = character.split(" ").collect {|word| word.capitalize}.join(" ")
  films = get_character_movies_from_api(character)
 
  if films.class == String
    "That character does not exist, Trekkie."
  else
    print_movies(films)
  end
end

def get_opening_crawl(movie)
  response_string = RestClient.get('http://www.swapi.co/api/films/')
  response_hash = JSON.parse(response_string)

  film = response_hash["results"].find {|film| film["title"].downcase == movie}
 crawl_array = film["opening_crawl"].split("\r\n")
 crawl_array.each do |line| 
  puts line
  sleep 1
 end
end

# puts get_character_movies_from_api("Luke Skywalker")
# puts show_character_movies("luke skywalker")
## BONUS

# puts get_opening_crawl("A New Hope")

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
