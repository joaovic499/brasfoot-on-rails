class StatsController < ApplicationController
  def index
    @career = Career.current
    @team = @career&.team
    @stats = LeagueStats.new
    @played = Match.where(played: true).count
    @scorers = @stats.top_scorers
    @assisters = @stats.top_assists
    @min_games = @stats.min_games_for_rating
    @best = @stats.best_rated

    @sort = LeagueStats::SORTS.key?(params[:sort]) ? params[:sort] : "goals"
    @dir = params[:dir] == "asc" ? "asc" : "desc"
    @team_rows = @team ? @stats.team_rows(@team, sort: @sort, dir: @dir) : []
  end
end
