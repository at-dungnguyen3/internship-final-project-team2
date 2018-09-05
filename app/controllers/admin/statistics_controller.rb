# frozen_string_literal: true

module Admin
  class StatisticsController < AdminController
    def index
      if params[:type]
        @objs = params[:type].constantize.where('created_at >= ? AND created_at <= ?', params[:start_at], params[:end_at])
        @count = @objs.size
        @data = @objs.paginate(page: params[:page], per_page: 10)
      else
        @data = []
      end
    end

    def chart
      chart = []
      start_at = params[:start_at].to_date
      end_at = params[:end_at].to_date
      while start_at <= end_at
        chart << [start_at, params[:obj].constantize.where('created_at >= ? AND created_at < ?', start_at, start_at + 1).size]
        start_at += 1
      end

      respond_to do |format|
        format.json { render json: chart }
      end
    end
  end
end
