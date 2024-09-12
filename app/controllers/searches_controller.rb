class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    @search.save

    # @search.update(scope: ClassifySearchQueryService.new(@search.query, search_id: @search.id).call)

    if @search.save
      @search.update(result: SearchResultsService.new(@search.query, @search.scope, search_id: @search.id).call)
      redirect_to @search
    else
      render :new
    end
  end

  def show
    @search = Search.find(params[:id])
  end

  private

  def search_params
    params.require(:search).permit(:query, :scope)
  end
end
