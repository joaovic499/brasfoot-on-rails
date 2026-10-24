namespace :db do
  desc "Exporta TODOS os times e jogadores do banco para db/seeds_backup.rb (use OUT=caminho para mudar o arquivo)"
  task export_seed: :environment do
    path = Rails.root.join(ENV.fetch("OUT", "db/seeds_backup.rb"))
    teams = Team.order(:id).to_a

    out = []
    out << "# Gerado por `bin/rails db:export_seed` em #{Time.current}"
    out << "# [nome, posição principal, força, [posições secundárias] ou nil, [ritmo, finalização, passe, condução, defesa, físico]]"
    out << "# Posições: GK CB LB RB CDM CM LM RM CAM LW RW ST"
    out << "SQUADS = {"
    teams.each_with_index do |t, ti|
      out << "  #{t.name.inspect} => {"
      out << "    short: #{t.short_name.inspect}, color: #{t.color.inspect}, stadium: #{t.stadium.inspect},"
      out << "    players: ["
      players = t.players.order(:id).to_a
      players.each_with_index do |p, i|
        alts = p.secondary_positions
        item = "[#{p.name.inspect}, #{p.position.inspect}, #{p.overall}"
        if p.attrs_filled?
          item += ", #{alts.any? ? "%w[#{alts.join(' ')}]" : 'nil'}, [#{Player::ATTRS.map { |a| p[a] }.join(', ')}]"
        elsif alts.any?
          item += ", %w[#{alts.join(' ')}]"
        end
        item += "]"
        out << "      #{item}#{i < players.size - 1 ? ',' : ''}"
      end
      out << "    ]"
      out << "  }#{ti < teams.size - 1 ? ',' : ''}"
    end
    out << "}.freeze"
    out << ""
    out << <<~'RUBY'
      Career.destroy_all
      Match.destroy_all
      Team.where(name: SQUADS.keys).destroy_all

      SQUADS.each do |name, data|
        team = Team.create!(name: name, short_name: data[:short], color: data[:color], stadium: data[:stadium])
        data[:players].each do |pname, pos, ovr, alts, at|
          team.players.create!(name: pname, position: pos, overall: ovr, alt_positions: (alts || []).join(","),
                               pace: at&.[](0), shooting: at&.[](1), passing: at&.[](2),
                               dribbling: at&.[](3), defending: at&.[](4), physical: at&.[](5))
        end
        team.auto_lineup!("4-3-3")
      end

      puts "Seed ok: #{Team.count} times, #{Player.count} jogadores."
    RUBY

    File.write(path, out.join("\n") + "\n")
    puts "Exportado: #{teams.size} times, #{Player.count} jogadores -> #{path}"
  end
end
