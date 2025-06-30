let
  ROOT = builtins.toString ./.;
  main-hosts = builtins.readFile "${ROOT}/main-hosts";
  social-hosts = builtins.readFile "${ROOT}/social-hosts";
  extra-hosts = builtins.readFile "${ROOT}/extra-hosts";
in
{
  networking.extraHosts = ''
    ${main-hosts}
    ${social-hosts}
    ${extra-hosts}
  '';
}
