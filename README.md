# XFCE GENERIC MONITOR PANEL PLUGIN SCRIPTS

A collection of scripts for [`xfce4-genmon-plugin`](https://docs.xfce.org/panel-plugins/xfce4-genmon-plugin/start)

## `gpu_nvidia.sh` - Nvidia GPU Monitor

Shows information about the current state of your Nvidia GPU. **Not tested with multiple GPUs**.

### Preview

Panel | Tooltip | Click
--- | --- | ---
`1232 MiB \| 1065 MHz \| 48 ºC \| 23.20 W` | <pre>NVIDIA GeForce GTX 1660 Ti<br><br>— Memory —<br>Total: 6144 MiB<br>Used: 1232 iB<br>Free: 4703 MiB<br><br>— Clocks —<br>Graphics: 1065 MHz<br>Memory: 6000 MHz<br>Video: 990 MHz<br><br>— Info —<br>Driver: 510.73.05<br>CUDA: 11.6<br>BIOS: 90.16.25.40.A8<br>Serial: [N/A]<br><br>— PCIe —<br>Gen. current: 3<br>Gen. max: 3<br>Lanes current: 16<br>Lanes max: 16</pre> | `nvidia-settings`