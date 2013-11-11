defmodule Mix.Tasks.Deps.Loadpaths do
  use Mix.Task

  import Mix.Deps, only: [loaded: 0, available?: 1, load_paths: 1]

  @hidden true
  @shortdoc "Load all dependencies' paths"

  @moduledoc """
  Loads all dependencies. This is invoked directly
  by `loadpaths` when the CLI boots.

  ## Command line options

  * `--no-deps-check` - skip dependency check
  """
  def run(args) do
    { opts, _, _ } = OptionParser.parse(args)

    unless opts[:no_deps_check] do
      Mix.Task.run "deps.check"
    end

    lc dep inlist loaded, available?(dep) do
      Enum.each(load_paths(dep), &Code.prepend_path/1)
    end
  end
end
