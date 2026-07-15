#!/bin/bash

# Define the local version of notes as the most recent by copying it to remote (Jureca):
remote_rel2obs_dir='/p/scratch/amy-cryo/sommerhage2/AppPS1_newExt_Krios_20250228_SiSo/rel2obs/'
rsync -avPh ./rel2obs/ Judac:$remote_rel2obs_dir --delete


# run relion to obsidian script on Jureca:

ssh -T Judac << 'EOF'
rel_dir="/p/scratch/amy-cryo/sommerhage2/AppPS1_newExt_Krios_20250228_SiSo/relion_proc/"
out_dir="/p/scratch/amy-cryo/sommerhage2/AppPS1_newExt_Krios_20250228_SiSo/rel2obs/"

echo "Running rel2obsi_beta.py on Jureca ..."

mamba run -n simon-jlabenv python /p/home/jusers/sommerhage2/jureca/software/relion2obsidian/rel2obsi_beta.py \
        -i "$rel_dir" \
        -o "$out_dir" \
        --plot \
        --update-incomplete
EOF

# Download rel2obs output to local folder:
echo "Downloading notes to local ..."
rsync -avPh Judac:$remote_rel2obs_dir ./rel2obs

