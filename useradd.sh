#!/bin/bash
groupadd -g 100007 -r -o pod_chrom && useradd -g pod_chrom -r -o -M -e 1970-01-01 -u 100007 -s /sbin/nologin pod_chrom && usermod -aG audio,video pod_chrom
groupadd -g 100010 -r -o pod_okular && useradd -g pod_okular -r -o -M -e 1970-01-01 -u 100010 -s /sbin/nologin pod_okular
groupadd -g 100013 -r -o pod_gwen && useradd -g pod_gwen -r -o -M -e 1970-01-01 -u 100013 -s /sbin/nologin pod_gwen
groupadd -g 100015 -r -o pod_fzilla && useradd -g pod_fzilla -r -o -M -e 1970-01-01 -u 100015 -s /sbin/nologin pod_fzilla
groupadd -g 100019 -r -o pod_vs && useradd -g pod_vs -r -o -M -e 1970-01-01 -u 100019 -s /sbin/nologin pod_vs
groupadd -g 100021 -r -o pod_tg && useradd -g pod_tg -r -o -M -e 1970-01-01 -u 100021 -s /sbin/nologin pod_tg && usermod -aG audio,video pod_tg
groupadd -g 109823 -r -o pod_sayo && useradd -g pod_sayo -r -o -M -e 1970-01-01 -u 109823 -s /sbin/nologin pod_sayo && usermod -aG audio pod_sayo
groupadd -g 100025 -r -o pod_vlc && useradd -g pod_vlc -r -o -M -e 1970-01-01 -u 100025 -s /sbin/nologin pod_vlc && usermod -aG audio,video pod_vlc
groupadd -g 100027 -r -o pod_yt && useradd -g pod_yt -r -o -M -e 1970-01-01 -u 100027 -s /sbin/nologin pod_yt
groupadd -g 100119 -r -o pod_kee && useradd -g pod_kee -r -o -M -e 1970-01-01 -u 100119 -s /sbin/nologin pod_kee
groupadd -g 100124 -r -o pod_unbound && useradd -g pod_unbound -r -o -M -e 1970-01-01 -u 100124 -s /sbin/nologin pod_unbound
