{
  description = ''System libraries for the Genode Operating System Framework'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-genode-v18_11.flake = false;
  inputs.src-genode-v18_11.ref   = "refs/tags/v18.11";
  inputs.src-genode-v18_11.owner = "~ehmry";
  inputs.src-genode-v18_11.repo  = "nim_genode";
  inputs.src-genode-v18_11.type  = "sourcehut";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-genode-v18_11"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-genode-v18_11";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}