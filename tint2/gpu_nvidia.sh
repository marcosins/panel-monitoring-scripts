#!/usr/bin/env bash
# Dependencies: bash, nvidia-smi, cut, head, xargs

# GENERAL SETUP
readonly SEPARATOR="" #︙·
readonly CELCIUS=" <sup>o</sup>C" # you might want `℃`, `ºC` or '<sup>o</sup>C` instead

# Main text that shows in the panel
TEXT=""

# NVIDIA GPU INFORMATION AND STATUS
# DOCS: `nvidia-smi --help-query-gpu`
# Get all information as CSV then splits it using `cut`
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
readonly GPU_MEM_USED=$(echo "${GPU_INFO}" | cut -d',' -f 2 | xargs)
## Frecuency and Clocks
readonly GPU_CLOCK_GRAPH=$(echo "${GPU_INFO}" | cut -d',' -f 4 | xargs)
## Power draw
readonly GPU_POWER_DRAW=$(echo "${GPU_INFO}" | cut -d',' -f 11 | xargs)
## Temperature
readonly GPU_TEMP=$(echo "${GPU_INFO}" | cut -d',' -f 12 | xargs)
## Model info and drivers
readonly GPU_MODEL="GTX 1660Ti" #$(echo "${GPU_INFO}" | cut -d',' -f 13 | xargs)

TEXT+="${GPU_MODEL} ${SEPARATOR} "
TEXT+="${GPU_MEM_USED} ${SEPARATOR} "
TEXT+="${GPU_CLOCK_GRAPH} ${SEPARATOR} "
TEXT+="${GPU_TEMP}${CELCIUS} ${SEPARATOR} "
TEXT+="${GPU_POWER_DRAW}"

# Show everything
echo -e "${TEXT}"

exit 0
