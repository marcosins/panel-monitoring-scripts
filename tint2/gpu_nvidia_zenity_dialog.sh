#!/usr/bin/env bash

# NVIDIA GPU INFORMATION AND STATUS
# DOCS: `nvidia-smi --help-query-gpu`
# Get all information as CSV then gets each column with `cut`
readonly GPU_INFO=$(nvidia-smi --query-gpu=\
memory.total,\
memory.used,\
memory.free,\
clocks.current.graphics,\
clocks.current.memory,\
clocks.current.video,\
pcie.link.gen.current,\
pcie.link.gen.max,\
pcie.link.width.current,\
pcie.link.width.max,\
power.draw,\
temperature.gpu,\
gpu_name,\
gpu_serial,\
driver_version,\
vbios_version \
--format=csv,noheader)
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

# TEXT to show on mouse over. Format is pango markup
# DOCS: https://developer-old.gnome.org/pygtk/stable/pango-markup-language.html
TITLE+="${GPU_MODEL}"

TEXT=""

### Memory
#TEXT+="\n<b>MEMORY</b>\n"
#TEXT+="<tt>"
#TEXT+="Total         : ${GPU_MEM_TOTAL}\n"
#TEXT+="Used          : ${GPU_MEM_USED}\n"
#TEXT+="Free          : ${GPU_MEM_FREE}\n"
#TEXT+="</tt>"
#
### Clocks
#TEXT+="\n<b>CLOCKS</b>\n"
#TEXT+="<tt>"
#TEXT+="Graphics      : ${GPU_CLOCK_GRAPH}\n"
#TEXT+="Memory        : ${GPU_CLOCK_MEM}\n"
#TEXT+="Video         : ${GPU_CLOCK_VIDEO}\n"
#TEXT+="</tt>"

## PCI Express
TEXT+="\n<b>PCI</b>\n"
TEXT+="<tt>"
TEXT+=" Gen. current  : ${GPU_PCIE_GEN_USING}\n"
TEXT+=" Gen. max      : ${GPU_PCIE_GEN_MAX}\n"
TEXT+=" Lanes current : ${GPU_PCIE_LANES_USING}\n"
TEXT+=" Lanes max     : ${GPU_PCIE_LANES_MAX}\n"
TEXT+="</tt>"

## Information
TEXT+="\n<b>INFORMATION</b>\n"
TEXT+="<tt>"
TEXT+=" Driver        : ${GPU_DRIVER}\n"
TEXT+=" CUDA          : ${GPU_CUDA}\n"
TEXT+=" BIOS          : ${GPU_BIOS}\n"
TEXT+=" Serial        : ${GPU_SERIAL}"
TEXT+="</tt>"

zenity --info --text="${TEXT}" --title="${TITLE}" --icon-name="nvidia" --ellipsize
