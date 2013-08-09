require 'spec_helper'

describe Movie do
  describe 'find movies with the same director' do
    it 'should search for movies with same director' do
      fake_movie = mock('Movie', :director => 'My director')
      Movie.should_receive(:find).with('1').and_return(fake_movie)
      fake_result = [mock('Movie'), mock('Movie')]
      Movie.should_receive(:find_all_by_director).with('My director').and_return(fake_result)
      Movie.find_same_director('1')
    end

    it 'should raise an error if there is no director' do
      fake_movie = mock('Movie', :director => '')
      Movie.should_receive(:find).with('1').and_return(fake_movie)
      lambda {Movie.find_same_director('1')}.should raise_error(Movie::NoDirectorInfo)
    end
  end
end
