class Converter
  def initialize(file_path)
    @filename = File.basename(file_path, '.*')
  end

  def convert_and_highlight
    convert_markdown_to_html
    read_highlight_scripts
    read_html_file
    highlight_code_blocks
    write_to_back_to_html_file
  end

  private
  def convert_markdown_to_html
    `pandoc -f markdown -t html -o #{@filename}.html #{@filename}.md`
  end

  def read_highlight_scripts
    @lines = [
        "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/8.6/styles/androidstudio.min.css\">\n",
        "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/8.6/highlight.min.js\"></script>\n",
        "<script>hljs.initHighlightingOnLoad();</script>\n"
    ]
  end

  def read_html_file
    @lines += File.open("#{@filename}.html", 'r').readlines
  end

  def highlight_code_blocks
    @lines.each do |line|
      line.gsub!(/<pre class="sourceCode (?:\w*)>"/, '<pre>')
      line.gsub!(/<code class="sourceCode (\w*)"/, '<code class="\1"')
    end
  end

  def write_to_back_to_html_file
    File.delete("#{@filename}.html")
    File.open("#{@filename}.html", 'w') { |file| @lines.each { |line| file.puts(line) } }
  end
end