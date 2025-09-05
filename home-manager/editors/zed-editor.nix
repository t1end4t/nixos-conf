{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    # settings = {
    #   # Default assistant provider → OpenRouter
    #   "assistant.default_provider" = "openrouter";

    #   # Providers
    #   "assistant.providers" = {
    #     openrouter = {
    #       api_url = "https://openrouter.ai/api/v1";
    #       # you’ll need to export your API key in env or here if supported
    #       # api_key = "YOUR_OPENROUTER_API_KEY";
    #     };

    #     gemini = {
    #       # In recent Zed versions, Gemini works via the Gemini CLI
    #       # If it's in PATH, you don't need to set cli_path
    #       # cli_path = "/home/you/.local/bin/gemini";
    #     };
    #   };

    #   # Order of fallback/selection
    #   "assistant.provider_order" = [
    #     "openrouter"
    #     "gemini"
    #   ];
    # };
  };
}
