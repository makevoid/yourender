module Translation
  def t(en, it=en)
    LANG == "en" ? en : it
  end
end