Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    if !Movie.find_by_title_and_rating(movie[:title], movie[:rating]) then
      Movie.create!(movie)
    end
  end
  assert (Movie.count >= movies_table.hashes.count), "Error initializing DB"
end
Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  movie = Movie.find_by_title(title)
  movie.director.should == director
end
