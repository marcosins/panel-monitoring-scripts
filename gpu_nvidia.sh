#!/bin/bash
# Dependencies: bash, nvidia-smi, cut, grep, head, xargs

# DOCS: `nvidia-smi --help-query-gpu`
# --- GENERAL INFO ---
readonly GPU_MODEL="$(nvidia-smi --query-gpu=gpu_name --format=csv,noheader)"
readonly GPU_SERIAL="$(nvidia-smi --query-gpu=gpu_serial --format=csv,noheader)"
readonly GPU_DRIVER=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader)
readonly GPU_CUDA=$(nvidia-smi -q -u | grep CUDA | head -n 1 | cut -d ':' -f 2 | cut -d' ' -f 2)
readonly GPU_BIOS=$(nvidia-smi --query-gpu=vbios_version --format=csv,noheader)
# --- PCI EXPRESS BUS ---
readonly GPU_PCIE_GEN_USING=$(nvidia-smi --query-gpu=pcie.link.gen.current --format=csv,noheader)
readonly GPU_PCIE_GEN_MAX=$(nvidia-smi --query-gpu=pcie.link.gen.max --format=csv,noheader)
readonly GPU_PCIE_LANES_USING=$(nvidia-smi --query-gpu=pcie.link.width.current --format=csv,noheader)
readonly GPU_PCIE_LANES_MAX=$(nvidia-smi --query-gpu=pcie.link.width.max --format=csv,noheader)
# --- MEMORY ---
readonly GPU_MEM_TOTAL=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader)
readonly GPU_MEM_USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader)
readonly GPU_MEM_FREE=$(nvidia-smi --query-gpu=memory.free --format=csv,noheader)
# --- FREQUENCY/CLOCKS ---
readonly GPU_CLOCK_GRAPH=$(nvidia-smi --query-gpu=clocks.current.graphics --format=csv,noheader)
readonly GPU_CLOCK_MEM=$(nvidia-smi --query-gpu=clocks.current.memory --format=csv,noheader)
readonly GPU_CLOCK_VIDEO=$(nvidia-smi --query-gpu=clocks.current.video --format=csv,noheader)
# --- POWER ---
readonly GPU_POWER_DRAW=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader)
# --- TEMPERATURE ---
readonly GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)

readonly APP_TO_RUN="nvidia-settings"



# Tooltip to show on mouse over
TOOLTIP="${GPU_MODEL}\n"
TOOLTIP+="\n— Memory —\n"
TOOLTIP+="Total: ${GPU_MEM_TOTAL}\n"
TOOLTIP+="Used: ${GPU_MEM_USED}\n"
TOOLTIP+="Free: ${GPU_MEM_FREE}\n"

TOOLTIP+="\n— Clocks —\n"
TOOLTIP+="Graphics: ${GPU_CLOCK_GRAPH}\n"
TOOLTIP+="Memory: ${GPU_CLOCK_MEM}\n"
TOOLTIP+="Video: ${GPU_CLOCK_VIDEO}\n"

TOOLTIP+="\n— Info —\n"
TOOLTIP+="Driver: ${GPU_DRIVER}\n"
TOOLTIP+="CUDA: ${GPU_CUDA}\n"
TOOLTIP+="BIOS: ${GPU_BIOS}\n"
TOOLTIP+="Serial: ${GPU_SERIAL}\n"

TOOLTIP+="\n— PCIe —\n"
TOOLTIP+="Gen. current: ${GPU_PCIE_GEN_USING}\n"
TOOLTIP+="Gen. max: ${GPU_PCIE_GEN_MAX}\n"
TOOLTIP+="Lanes current: ${GPU_PCIE_LANES_USING}\n"
TOOLTIP+="Lanes max: ${GPU_PCIE_LANES_MAX}\n"


echo -e "<txt>${GPU_MEM_USED} | ${GPU_CLOCK_GRAPH} | ${GPU_TEMP} ºC | ${GPU_POWER_DRAW}</txt>"
echo -e "<txtclick>${APP_TO_RUN}</txtclick>"
echo -e "<tool>${TOOLTIP}</tool>"

exit 0
