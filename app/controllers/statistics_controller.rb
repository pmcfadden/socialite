class StatisticsController < ApplicationController
  def index
    @statistics = Statistics.load
  end
end
