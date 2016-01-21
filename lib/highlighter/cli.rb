require 'clamp'
require 'highlighter/subcommands/markdown2html'
require 'highlighter/subcommands/list_themes'
require 'highlighter/subcommands/list_languages'

module Highlighter
  class Cli < Clamp::Command
    subcommand %w(markdown2html m2h), 'Converts markdown to html with syntax highlighting for code blocks',
               Subcommands::Markdown2Html

    subcommand 'themes', 'Lists available themes', Subcommands::ListThemes
    subcommand 'languages', 'Lists available languages with syntax highlighting', Subcommands::ListLanguages
  end
end