#!/bin/bash

declare -r HEAP_MEM=${AGENT_HEAP_SIZE:-512m}

declare -ra JAVA_OPTS_ARRAY=(
   -server
   # Point to rendered config file.
   -Dconfig.file=/etc/application.conf
   # Constrain memory.
   -Xmx${HEAP_MEM}
   -Xms${HEAP_MEM}
   # GC settings (copied from Clio for now).
   -XX:+PrintFlagsFinal
   -XX:+PrintGCTimeStamps
   -XX:+PrintGCDateStamps
   -XX:+PrintGCDetails
)

# Inject options into normal entrypoint.
JAVA_OPTS="${JAVA_OPTS_ARRAY[*]}" exec /app/bin/transporter-aws-to-gcp-agent