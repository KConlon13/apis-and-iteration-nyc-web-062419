#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
movie = get_movie_from_user
puts get_opening_crawl(movie)