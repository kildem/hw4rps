Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    if !Movie.find_by_title_and_rating(movie[:title], movie[:rating]) then
      Movie.create!(movie)
    end
  end
  assert (Movie.count >= movies_table.hashes.count), "Error initializing DB"
end
