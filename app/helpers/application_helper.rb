module ApplicationHelper
  def ovr_class(o)
    if o >= 88 then "ovr green"
    elsif o >= 75 then "ovr gold"
    else "ovr gray"
    end
  end

  def ovr_badge(o)
    content_tag(:span, o.round, class: ovr_class(o))
  end

  # Cor do card estilo FIFA
  def card_tier(o)
    if o >= 88 then "t-elite"
    elsif o >= 75 then "t-gold"
    elsif o >= 65 then "t-silver"
    else "t-bronze"
    end
  end

  # Nome curto para caber no card
  def card_name(name)
    return name if name.length <= 11
    last = name.split.last
    last.length <= 2 ? name : last
  end

  # Resumo dos atributos do jogador para tooltips e UI
  def attrs_summary(player)
    return "Sem atributos" unless player.respond_to?(:attr)

    Player::ATTRS.map do |attr|
      "#{Player::ATTR_LABELS[attr]}: #{player.attr(attr)}"
    end.join(" • ")
  end

  # Escudo do time com fallback para a sigla caso não exista imagem
  def team_crest(team, size: 44, klass: nil)
    return "" if team.nil?

    asset = "teams/#{team.short_name.to_s.downcase}.svg"
    asset_path = Rails.root.join("app/assets/images", asset)
    alt = team.name.to_s
    classes = ["team-crest", klass].compact.join(" ")

    if asset_path.exist?
      image_tag(asset, alt: alt, class: classes, width: size, height: size)
    else
      content_tag(:span, team.short_name, class: "team-crest-fallback #{classes}", style: "width:#{size}px;height:#{size}px;background:#{team.color};")
    end
  end

  # Kit do time em estilo card de futebol
  def team_kit(team, size: 18)
    return "" if team.nil?

    content_tag(:span, team.short_name, class: "team-kit", style: "--kit-primary:#{team.color}; --kit-secondary:#{team.color}; width:#{size * 2.8}px; height:#{size}px;")
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
