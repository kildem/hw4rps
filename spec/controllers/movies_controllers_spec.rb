require 'spec_helper'

describe MoviesController do
  #test def show
  describe 'find a movie' do
    it 'should show the movie information' do
      movie = mock('Movie')
      Movie.should_receive(:find).with('1').and_return(movie)
      get :show, {:id => '1'}
      response.should render_template('show')
    end
  end
  #test def index 
  describe 'list all movies' do
    it 'should find and list all movies' do
      fake_results = 'movies'
      Movie.should_receive(:find_all_by_rating).and_return(fake_results)
      get :index
      response.should render_template('index')
    end
    
    it 'should find list all movies, sort by title' do
      get :index, {:sort => 'title', :ratings => 'G'}
      response.should redirect_to(:sort => 'title', :ratings => 'G')
    end
    
    it 'should find all movies, sort by release_date' do
      get :index, {:sort => 'release_date', :ratings => 'G'}
      response.should redirect_to(:sort => 'release_date', :ratings => 'G')
    end
    
    it 'should find list all movies with rating G' do
      get :index, {:ratings => 'G'}
      response.should redirect_to(:ratings => 'G')
    end
  end
  #test def new
  describe 'show form to add a movie' do
    it 'should show the form for user to create new movie' do
      get :new
      response.should render_template('new')
    end
  end
  #test def create
  describe 'create a movie' do
    it 'should create a new movie successfully' do
      movie = mock('Movie', :title => 'Hardware')
      Movie.should_receive(:create!).and_return(movie)
      post :create, :movie => movie
      response.should redirect_to(movies_path)
    end
  end
  #test def edit
  describe 'edit a movie' do
    it 'should show form to edit the movie information' do
      movie = mock('Movie')
      Movie.should_receive(:find).with('1').and_return(movie)
      post :edit, :id => '1'
      response.should render_template('edit')
    end
  end
  #test def update
  describe 'update a movie' do
    it 'should save the update movie information' do
      movie = mock('Movie', :id => '1', :title => 'Hardware')
      Movie.should_receive(:find).with('1').and_return(movie)
      movie.should_receive(:update_attributes!)
      put :update, :id => '1', :movie => movie
      response.should redirect_to movie_path(movie)
    end
  end
  #test def destroy
  describe 'delete a movie' do
    it 'should delete the movie' do
      movie = mock('Movie', :id => '1', :title => 'Hardware')
      Movie.should_receive(:find).with('1').and_return(movie)
      movie.should_receive(:destroy)
      delete :destroy, :id => '1'
      response.should redirect_to(movies_path)
    end
  end
  #test def same_director
  describe 'find movies with the same director' do
    it 'should show other movies with the same director' do
      movie = mock('Movie', :title => 'Hardware')
      movie.stub(:director).and_return('Director Name')
      Movie.should_receive(:find).with('1').and_return(movie)
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.should_receive(:find_same_director).with('1').and_return(fake_results)
      get :same_director, {:id => '1'}
      response.should render_template('same_director')
    end
    
    it 'should redirect to home page and show a warning for no director info' do
      movie = mock('Movie', :title => 'Hardware')
      Movie.should_receive(:find).with('1').and_return(movie)
      Movie.stub(:find_same_director).and_raise(Movie::NoDirectorInfo)
      get :same_director, {:id => '1'}
    end
  end
  
end