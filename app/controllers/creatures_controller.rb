class CreaturesController < ApplicationController
require 'flickraw'

FlickRaw.api_key = "PROCESS.ENV.KEY"
FlickRaw.shared_secret = "PROCESS.ENV.SECRET"

  def index
    @msg = "Hello Scientists"
    @creatures = Creature.all
    @tags = Tag.all
  end

  def new
    @creature = Creature.new
  end

  def create
    @creature = Creature.create(creature_params)
    params[:creature][:tags].each do |tag_id|
      @creature.tags << Tag.find(tag_id) unless tag_id.blank?
    end
    redirect_to @creature
  end

  def tag
    tags = Tag.find_by_id(params[:tags_id])
      @creatures = tag ? tag.creatures : []
  end

  def show
    @creature = Creature.find(params[:id])

   list = flickr.photos.search :text => @creature.name, :sort => "relevance"
   photos = list.map do |i|
      "https:/farm3.static.flickr.com/#{i["server"]}/" "#{i["id"]}_" "#{i["secret"]}_n.jpg"
   end
   @photo = photos.sample
  end

  def edit
    @creature = Creature.find(params[:id])
    @tag = Tag.all
  end

  def update
    @creature = Creature.update(params[:id], creature_params)
    @creature.tags.clear
    params[:creature][:tags].each do |tag_id|
      @creature.tags << Tag.find(tag_id) unless tag_id.blank?
  end
    redirect_to @creature
  end

private

  def creature_params
    params.require(:creature).permit(:name,:description, :tags)
  end

end