#!/bin/bash -e

if [ ! -z ${PR_PROFILES[@]+x} ]; then
    for profile in ${PR_PROFILES[@]}; do
        job_name="PR_JOB_NAME_${profile}"
        scrape_interval="PR_SCRAPE_INTERVAL_${profile}"
        metrics_path="PR_METRIC_PATH_${profile}"
        targets="PR_TARGET_${profile}"
        if [ ! -z "${!job_name}" ] && [ ! -z "${!scrape_interval}" ] && [ ! -z "${!metrics_path}" ] && [ ! -z "${!targets}" ]; then
            echo " " >> /etc/prometheus/prometheus.yml
            echo "  - job_name: ${!job_name}" >> /etc/prometheus/prometheus.yml
            echo "    scrape_interval: ${!scrape_interval}" >> /etc/prometheus/prometheus.yml
            echo "    metrics_path: ${!metrics_path}" >> /etc/prometheus/prometheus.yml
            echo "    static_configs:" >> /etc/prometheus/prometheus.yml
            echo "    - targets: ['${!targets}']" >> /etc/prometheus/prometheus.yml
        else
           echo "*** Missing variables for profile '${profile}'" 1>&2
          exit 1
        fi
    done
fi

prometheus -config.file=/etc/prometheus/prometheus.yml \
           -storage.local.path=/prometheus \
           -web.console.libraries=/usr/share/prometheus/console_libraries
           -web.console.templates=/usr/share/prometheus/consoles
