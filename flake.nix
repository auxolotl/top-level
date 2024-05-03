{
  inputs = {
    core.url = "github:auxolotl/packages";

    javascript = {
      url = "github:auxolotl/javascript";
      inputs.top-level.follows = "";
    };
  };

  outputs = { self, core, javascript }: {
    inherit core;

    javascript = javascript.topLevelOut { inherit core; };
  };
}
