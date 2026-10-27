{ inputs, ... }:

{
  # Provides the `flake.modules.<class>.<name>` option every feature writes to.
  imports = [ inputs.flake-parts.flakeModules.modules ];
}
