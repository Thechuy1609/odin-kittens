class KittensController < ApplicationController
  def new
    @kitten = Kitten.new
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @kittens }
      format.json { render :json => @kittens }
    end
  end

  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @kittens }
      format.json { render :json => @kittens }
    end
  end

  def create
    @kitten = Kitten.build(kitten_params)
    if @kitten.save
      flash[:success] = 'Kitten successfully created'
      redirect_to kittens_path
    else
      flash.now[:error] = 'Something went wrong lmao'
      render :new
    end
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update(kitten_params)
      redirect_to kittens_path, notice: 'Kitten was successfully updated.'
    else
      render :edit,  notice: 'You cant Kill me!'
    end
  end


  def edit
    @kitten = Kitten.find(params[:id])
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    redirect_to root_path, notice: 'Kitten was successfully killed :('
  end

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
