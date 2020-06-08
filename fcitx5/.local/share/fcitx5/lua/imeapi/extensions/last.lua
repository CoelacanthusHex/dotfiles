function last()
  return ime.get_last_commit()
end
ime.register_trigger("last", "get last commit", {"last"}, {"重复"})
