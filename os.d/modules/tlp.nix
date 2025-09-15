{ config, pkgs, ... }:
{
  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;

      CPU_SCALING_GOVERNOR_ON_AC  = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_MAX_PERF_ON_BAT = 40;
      CPU_BOOST_ON_BAT = 0;

      SCHED_POWERSAVE_ON_BAT = 1;

      RUNTIME_PM_ON_AC  = "on";
      RUNTIME_PM_ON_BAT = "auto";
      PCI_EXPRESS_ASPM_ON_AC  = "default";
      PCI_EXPRESS_ASPM_ON_BAT = "powersave";

      DISK_IDLE_SECS_ON_BAT = 2;
      SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
      AHCI_RUNTIME_PM_ON_BAT = "auto";
      NVME_APST_ON_BAT = 1;
      NVME_APST_MAX_LATENCY_ON_BAT = 30000;

      USB_AUTOSUSPEND = 1;

      WIFI_PWR_ON_BAT = "on";
      WOL_DISABLE = "Y";

      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";
    };
  };
}
