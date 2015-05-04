class TagsController < ApplicationController



  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create(tag_params)
    @tags = Tag.all
    redirect_to root_path
  end

  def show
    @tag = Tag.find(params[:id])
    @creatures = @tag.creatures
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.update(params[:id], tag_params)
    redirect_to @tag
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.creatures.length < 1
      @tag.destroy
    redirect_to tags_path
    else
      redirect_to tags_path
      flash[:danger] = "Can't DO IT"
    end

    # @tags = Tag.destory.where
    # --- I got to go now, but you are close you need to find the tag by id and then .destroy (Sanda)
  end

private

  def tag_params
    params.require(:tag).permit(:name)
  end



end