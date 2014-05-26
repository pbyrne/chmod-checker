class CheckerController < ApplicationController
  def index
  end

  def show
    @chmod = ChmodParser.new(params[:statement]).chmod
  rescue ChmodParser::MissingMode
    flash[:error] = "You must provide a chmod mode statement."
    redirect_to root_path
  rescue ChmodParser::InvalidMode
    flash[:error] = "Invalid chmod mode '#{params[:statement]}'."
    redirect_to root_path
  end
end
