class DogsController < ApplicationController

    before_action :set_dog, only: [:show, :edit, :update, :destroy]

    def index
        @dogs = Dog.all
    end

    def new
        @dog = Dog.new #=> makes an empty dog to pass to our view
    end

    def create
        @dog = Dog.new(dog_params)
        if @dog.save
            # if it saves, go to the index
            redirect_to dogs_url, notice: 'Successfully saved'
        else
            #if it doesn't save, rerender the 'new' dog form
            flash.now[:notice] = "Something went wrong. We couldn't save your dog."
            render :new
        end
    end

    def show
        # @dog = Dog.find(params[:id])
    end

    def edit
        # @dog = Dog.find(params[:id])
    end

    def update
        # @dog = Dog.find(params[:id])
        if @dog.update(dog_params)
            redirect_to dog_url(@dog), notice: 'Successfully updated.'
        else
            flash.now[:notice] = "Something went wrong. We couldn't update #{@dog.name}."
            render :edit
        end
    end

    def destroy
        if @dog.destroy
            redirect_to dogs_url, notice: "Successfully deleted #{@dog.name}."
        else
            redirect_to dogs_url, notice: "Could not delete #{@dog.name}."
        end
    end

    private

    def dog_params
        params.require(:dog).permit(:name, :age, :breed, :owner)
    end 

    def set_dog
        @dog = Dog.find(params[:id])
    end
end
