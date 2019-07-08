def welcome
  system "open ./chewbacca.mp3"
  puts "WHRRRAAARGH!"
  # puts out a welcome message here!
end

def get_character_from_user
  puts "please enter a character name"
  character_name = gets.chomp
  # use gets to capture the user's input. This method should return that input, downcased.
  character_name.downcase
end

def get_movie_from_user
  puts "please enter a movie title"
  movie_name = gets.chomp
  # use gets to capture the user's input. This method should return that input, downcased.
  movie_name.downcase
end