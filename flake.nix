{
  inputs = {
    core.url = "github:auxolotl/packages";
  };

  outputs = { self, core }: {
    inherit core;
  };
}
