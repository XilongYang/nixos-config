{config, ... } :
{
  services.openssh = {
    enable = true;
    settings = {
      # 基础安全
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      ChallengeResponseAuthentication = false;
      
      # 行为明确
      UsePAM = true;
      X11Forwarding = false;
      AllowTcpForwarding = "no";  # server 默认不该给
      AllowAgentForwarding = "no";
      
      # 稳定性
      ClientAliveInterval = 60;
      ClientAliveCountMax = 3;
      
      # 日志（出事能查）
      LogLevel = "VERBOSE";
    };
  };
}
