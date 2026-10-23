module ApplicationHelper
  def ovr_class(o)
    if o >= 88 then "ovr gold"
    elsif o >= 84 then "ovr green"
    elsif o >= 80 then "ovr yellow"
    else "ovr gray"
    end
  end

  def ovr_badge(o)
    content_tag(:span, o.round, class: ovr_class(o))
  end

  # Cor do card estilo FIFA
  def card_tier(o)
    if o >= 88 then "t-elite"
    elsif o >= 82 then "t-gold"
    elsif o >= 76 then "t-silver"
    else "t-bronze"
    end
  end

  # Nome curto para caber no card
  def card_name(name)
    return name if name.length <= 11
    last = name.split.last
    last.length <= 2 ? name : last
  end

  # Força do jogador em cada posição (usado pelo JavaScript para mostrar a prévia da troca)
  def ratings_json(player)
    Positions::ORDER.index_with { |pos| player.rating_at(pos) }.to_json
  end

  # Partida em andamento (trava a navegação)
  def match_in_progress
    return @match_in_progress if defined?(@match_in_progress)
    @match_in_progress = Match.find_by(status: %w[live halftime])
  end

  def position_options
    Positions::ORDER.map { |c| ["#{c} — #{Positions::ALL[c][:name]}", c] }
  end

  # Já existe uma carreira iniciada? (antes disso o menu mostra só Painel e Jogadores)
  def career_started?
    return @career_started if defined?(@career_started)
    @career_started = Career.exists?
  end

  # Nota da partida / média de notas (0 a 10) como etiqueta colorida
  def rating_badge(r)
    return "—" if r.nil?
    cls = if r >= 7.5 then "ovr gold"
          elsif r >= 7.0 then "ovr green"
          elsif r >= 6.5 then "ovr yellow"
          else "ovr gray"
          end
    content_tag(:span, format("%.1f", r), class: cls)
  end
end
