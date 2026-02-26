let
  ROOT = builtins.toString ./.;
  main-hosts = builtins.readFile "${ROOT}/main-hosts";
  extra-hosts = builtins.readFile "${ROOT}/extra-hosts";
in
{
  networking.extraHosts = ''
    ${main-hosts}
    ${extra-hosts}
  '';
}
