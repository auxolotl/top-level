{
  inputs = {
    core.url = "github:auxolotl/core";

    javascript = {
      url = "github:auxolotl/javascript";
      inputs.core.follows = "core";
    };
  };

  outputs =
    {
      self,
      core,
      javascript,
    }:
    let
      forAllSystems =
        function:
        core.lib.genAttrs core.lib.systems.flakeExposed (
          system:
          function {
            nixPackages = core.nixPackages.${system};
            auxPackages = core.auxPackages.${system};
          }
        );
    in
    {
      inherit (core) lib nixPackages;

      auxPackages = forAllSystems (
        { nixPackages, ... }:
        let
          inherit (nixPackages.stdenv.hostPlatform) system;
        in
        {
          # TODO: uncomment when core exposes auxPackages
          # core = auxPackages;
          javascript = javascript.packages.${system};
        }
      );
    };
}
