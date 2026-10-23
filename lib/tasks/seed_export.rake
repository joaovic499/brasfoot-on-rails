namespace :db do
  desc "Exporta TODOS os times e jogadores do banco para db/seeds_backup.rb (use OUT=caminho para mudar o arquivo)"
  task export_seed: :environment do
    path = Rails.root.join(ENV.fetch("OUT", "db/seeds_backup.rb"))
    teams = Team.order(:id).to_a

    out = []
    out << "# Gerado por `bin/rails db:export_seed` em #{Time.current}"
    out << "# [nome, posição principal, força, [posições secundárias (até 2)]]"
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
        item += ", %w[#{alts.join(' ')}]" if alts.any?
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
        data[:players].each do |pname, pos, ovr, alts|
          team.players.create!(name: pname, position: pos, overall: ovr, alt_positions: (alts || []).join(","))
        end
        team.auto_lineup!("4-3-3")
      end

      puts "Seed ok: #{Team.count} times, #{Player.count} jogadores."
    RUBY

    File.write(path, out.join("\n") + "\n")
    puts "Exportado: #{teams.size} times, #{Player.count} jogadores -> #{path}"
  end
end
