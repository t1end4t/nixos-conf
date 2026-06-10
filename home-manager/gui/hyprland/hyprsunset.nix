{...}: {
  services.hyprsunset = {
    enable = true;
    settings = {
      max-gamma = 200;

      profile = [
        # Morning – Neutral
        {
          time = "6:00";
          identity = true;
        }

        # Evening – Windows Night Light-style warmth
        {
          time = "18:00";
          temperature = 4500;
          gamma = 1.0;
        }

        # Night – Gentle warm filter
        {
          time = "21:00";
          temperature = 3800;
          gamma = 0.9;
        }
      ];
    };
  };
}
