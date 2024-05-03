{
  inputs = {
    core.url = "github:auxolotl/packages";

    javascript = {
      url = "github:auxolotl/javascript";
      inputs.top-level.follows = "";
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
      inherit (core) lib;

      auxPackages = forAllSystems (
        { auxPackages, nixPackages, ... }:
        let
          inherit (nixPackages.stdenv.hostPlatform) system;
        in
        {
          core = auxPackages;
          javascript = javascript.packages.${system};
        }
      );
    };
}
