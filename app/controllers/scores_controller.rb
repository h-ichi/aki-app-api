# app/controllers/scores_controller.rb
class ScoresController < ApplicationController
  # POST /scores
  def create
    score = Score.new(score_params.merge(played_on: Date.current))
    if score.save
      render json: { success: true }, status: :created
    else
      render json: { success: false, errors: score.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /scores?level=1
  def index
    level = params[:level].to_i
    today = Date.current

    # 今日プレイされたスコアの上位10件
    top_scores = Score.where(level: level, played_on: today)
                      .where("remaining_time > 0")
                      .order(remaining_time: :desc)
                      .limit(10)
                      .select(:level, :remaining_time, :played_on)

    render json: top_scores
  end

  private

  def score_params
    params.require(:score).permit(:level, :remaining_time)
  end
end
