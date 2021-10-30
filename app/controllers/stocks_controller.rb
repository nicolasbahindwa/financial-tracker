class StocksController < ApplicationController

    def search
        # byebug
        if params[:stock].present?
            @stock = Stock.new_lookup(params[:stock])
            # render json: @stock
            if @stock
                # render 'users/my_portfolio'
                respond_to do |format|
                    format.js { render partial: 'users/result' }
                end
            else
                respond_to do |format|
                    flash.now[:alert] = "Incorrect symbol, try search again"
                    format.js { render partial: 'users/result'  }
                end
                # flash[:alert] = "Incorrect symbol, try search again"
                # redirect_to users_my_portfolio_path
            end
            
        else
            respond_to do |format|
                flash.now[:alert] = "Incorrect symbol, try search again"
                format.js { render partial: 'users/result'  }
            end
            # flash[:alert] = "Please enter a symbol to search"
            # redirect_to users_my_portfolio_path
        end 
    end
    
end