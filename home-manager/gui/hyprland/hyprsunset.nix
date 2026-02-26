{ ... }:
{
  services.hyprsunset = {
    enable = true;
    settings = {
      max-gamma = 300;

      profile = [
        # Morning – Neutral
        {
          time = "7:30";
          identity = true;
        }

        # Sunset – Warm transition
        {
          time = "18:00";
          temperature = 4200;
          gamma = 0.9;
        }

        # 21:00 – Very warm
        {
          time = "21:00";
          temperature = 2300;
          gamma = 0.55;
        }
      ];
    };
  };
}
