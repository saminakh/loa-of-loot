# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LoaOfLoot.Repo.insert!(%LoaOfLoot.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LoaOfLoot.Repo
alias LoaOfLoot.Configs.Zone
alias LoaOfLoot.Events
alias LoaOfLoot.Guilds

uldir = %Zone{name: "Uldir", id: 19}

if Repo.get(Zone, uldir.id) == nil do
  Repo.insert!(uldir)
end

"priv/repo/fixtures/logs.json"
|> File.read!()
|> Poison.decode!()
|> Enum.each(fn log ->
  duration = log["end"] - log["start"]
  zone = Repo.get(Zone, log["zone"])
  attrs = %{
    duration: duration,
    wcl_id: log["id"]
  }
  Guilds.create_log(attrs, zone)
end)

"priv/repo/fixtures/characters.json"
|> File.read!()
|> Poison.decode!()
|> Enum.each(& Guilds.create_character(%{name: &1}))

characters = Guilds.list_characters()
logs = Guilds.list_logs()

ability_id = 128275

1..50
|> Enum.each(fn _x ->
  count = Enum.random(1..5)
  caster = Enum.random(characters)
  target = Enum.random(characters)
  log = Enum.random(logs)
  Events.create_cast(%{
    ability_id: ability_id,
    count: count,
    target_id: target.id,
    caster_id: caster.id
  }, log)
end)
