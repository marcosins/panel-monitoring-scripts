#!/bin/bash
# Dependencies: bash, nvidia-smi, cut, grep, head, xargs

# GENERAL SETUP
readonly PANEL_TEXT_SEPARATOR=" · "
readonly RUN_ON_CLICK="nvidia-settings"
readonly CELCIUS=" ℃" # you might want `ºC` or '<sup>o</sup>C` instead

# NVIDIA GPU INFORMATION AND STATUS
# DOCS: `nvidia-smi --help-query-gpu`
# Get all information as CSV then gets each column with `cut`
readonly GPU_INFO=$(nvidia-smi --query-gpu=memory.total,memory.used,memory.free,clocks.current.graphics,clocks.current.memory,clocks.current.video,pcie.link.gen.current,pcie.link.gen.max,pcie.link.width.current,pcie.link.width.max,power.draw,temperature.gpu,gpu_name,gpu_serial,driver_version,vbios_version --format=csv,noheader)
## Memory
readonly GPU_MEM_TOTAL=$(echo "${GPU_INFO}" | cut -d',' -f 1 | xargs)
readonly GPU_MEM_USED=$(echo "${GPU_INFO}" | cut -d',' -f 2 | xargs)
readonly GPU_MEM_FREE=$(echo "${GPU_INFO}" | cut -d',' -f 3 | xargs)
## Frecuency and Clocks
readonly GPU_CLOCK_GRAPH=$(echo "${GPU_INFO}" | cut -d',' -f 4 | xargs)
readonly GPU_CLOCK_MEM=$(echo "${GPU_INFO}" | cut -d',' -f 5 | xargs)
readonly GPU_CLOCK_VIDEO=$(echo "${GPU_INFO}" | cut -d',' -f 6 | xargs)
## PCIe
readonly GPU_PCIE_GEN_USING=$(echo "${GPU_INFO}" | cut -d',' -f 7 | xargs)
readonly GPU_PCIE_GEN_MAX=$(echo "${GPU_INFO}" | cut -d',' -f 8 | xargs)
readonly GPU_PCIE_LANES_USING=$(echo "${GPU_INFO}" | cut -d',' -f 9 | xargs)
readonly GPU_PCIE_LANES_MAX=$(echo "${GPU_INFO}" | cut -d',' -f 10 | xargs)
## Power draw
readonly GPU_POWER_DRAW=$(echo "${GPU_INFO}" | cut -d',' -f 11 | xargs)
## Temperature
readonly GPU_TEMP=$(echo "${GPU_INFO}" | cut -d',' -f 12 | xargs)
## Model info and drivers
readonly GPU_MODEL=$(echo "${GPU_INFO}" | cut -d',' -f 13 | xargs)
readonly GPU_SERIAL=$(echo "${GPU_INFO}" | cut -d',' -f 14 | xargs)
readonly GPU_DRIVER=$(echo "${GPU_INFO}" | cut -d',' -f 15 | xargs)
readonly GPU_BIOS=$(echo "${GPU_INFO}" | cut -d',' -f 16 | xargs)
readonly GPU_CUDA=$(nvidia-smi -q -u | grep CUDA | head -n 1 | cut -d ':' -f 2 | xargs)

# Main text that shows in the panel
PANEL_TEXT="<txt><tt>"
PANEL_TEXT+="${GPU_MEM_USED}${PANEL_TEXT_SEPARATOR}"
PANEL_TEXT+="${GPU_CLOCK_GRAPH}${PANEL_TEXT_SEPARATOR}"
PANEL_TEXT+="${GPU_TEMP}${CELCIUS}${PANEL_TEXT_SEPARATOR}"
PANEL_TEXT+="${GPU_POWER_DRAW}"
PANEL_TEXT+="</tt></txt>"

# Tooltip to show on mouse over. Format is pango markup
# DOCS: https://developer-old.gnome.org/pygtk/stable/pango-markup-language.html
TOOLTIP="<tool><tt>"
TOOLTIP+="<big><b>${GPU_MODEL}</b></big>\n"
## Memory
TOOLTIP+="\n<span weight='bold'>MEMORY</span>\n"
TOOLTIP+="Total : ${GPU_MEM_TOTAL}\n"
TOOLTIP+="Used  : ${GPU_MEM_USED}\n"
TOOLTIP+="Free  : ${GPU_MEM_FREE}\n"
## Clocks
TOOLTIP+="\n<span weight='bold'>CLOCKS</span>\n"
TOOLTIP+="Graphics : ${GPU_CLOCK_GRAPH}\n"
TOOLTIP+="Memory   : ${GPU_CLOCK_MEM}\n"
TOOLTIP+="Video    : ${GPU_CLOCK_VIDEO}\n"
## PCI Express
TOOLTIP+="\n<span weight='bold'>PCI EXPRESS</span>\n"
TOOLTIP+="Gen. current  : ${GPU_PCIE_GEN_USING}\n"
TOOLTIP+="Gen. max      : ${GPU_PCIE_GEN_MAX}\n"
TOOLTIP+="Lanes current : ${GPU_PCIE_LANES_USING}\n"
TOOLTIP+="Lanes max     : ${GPU_PCIE_LANES_MAX}\n"
## Information
TOOLTIP+="\n<span weight='bold'>INFORMATION</span>\n"
TOOLTIP+="Driver : ${GPU_DRIVER}\n"
TOOLTIP+="CUDA   : ${GPU_CUDA}\n"
TOOLTIP+="BIOS   : ${GPU_BIOS}\n"
TOOLTIP+="Serial : ${GPU_SERIAL}"

TOOLTIP+="</tt></tool>"

# Show everything
echo -e "${PANEL_TEXT}"
echo -e "<txtclick>${RUN_ON_CLICK}</txtclick>"
echo -e "${TOOLTIP}"

exit 0
