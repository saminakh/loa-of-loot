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

"priv/repo/fixtures/logs.json"
|> File.read!()
|> Poison.decode!()
|> Enum.each(fn log ->
  duration = log["end"] - log["start"]

  struct = %LoaOfLoot.Guilds.Log{
    duration: duration,
    log_id: log["id"],
    zone: log["zone"]
  }
  LoaOfLoot.Repo.insert!(struct)
end)

"priv/repo/fixtures/characters.json"
|> File.read!()
|> Poison.decode!()
|> Enum.each(& LoaOfLoot.Repo.insert(%LoaOfLoot.Guilds.Character{name: &1}))

characters = LoaOfLoot.Guilds.list_characters()
logs = LoaOfLoot.Guilds.list_logs()

ability_id = 128275

1..50
|> Enum.each(fn x ->
  caster = Enum.random(characters)
  target = Enum.random(characters)
  log = Enum.random(logs)
  LoaOfLoot.Repo.insert!(%LoaOfLoot.Events.Cast{
    ability_id: ability_id,
    target_id: target.id,
    caster_id: caster.id,
    log_id: log.id
  })
end)
