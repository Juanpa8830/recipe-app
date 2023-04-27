class FoodsController < ApplicationController
    before_action :authenticate_user!
    
    def index
    @foods = Food.all
    end
    
    def new
    @food = Food.new
    end
    
    def destroy
    @food = Food.find(params[:id]).destroy
    respond_to do |format|
        format.html { redirect_to foods_path, notice: 'food deleted successfully' }
    end
    end
    
    def create
        @food = Food.new(food_params)
        @food.user_id = current_user.id
        if @food.save
          redirect_to foods_path, notice: 'Food was successfully created.'
        else
          render :new
        end
      end
    
      private
    
      def food_params
        params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
      end
    
    end