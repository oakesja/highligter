module FileUtils
  def with_tabs(output, num_tabs)
    '  ' * num_tabs + output
  end
end