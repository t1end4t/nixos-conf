{ pkgs }:

pkgs.buildNpmPackage rec {
  pname = "claude-code";
  version = "2.1.69";

  src = pkgs.fetchurl {
    url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
    hash = "sha256-RbQCHPNBdLrMT0DSIAZyRIovSkDf8JBPJbpbIVD5EK0=";
  };

  # Since the tarball doesn't have a package-lock.json, buildNpmPackage might fail.
  # If that happens, we need to generate one.
  # Note: @anthropic-ai/claude-code version 2.1.69

  npmDepsHash = pkgs.lib.fakeHash;

  # We skip the build phase as this is a pre-built CLI tool
  dontNpmBuild = true;

  sourceRoot = "package";

  meta = with pkgs.lib; {
    description = "Claude Code: Anthropic's official CLI for Claude";
    homepage = "https://www.npmjs.com/package/@anthropic-ai/claude-code";
    license = licenses.unfree;
    mainProgram = "claude";
  };
}
