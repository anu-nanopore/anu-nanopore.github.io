## Note this script writes a script to qsub one *.tar.gz file on the NCI and basecall with albacore
## To generate scripts call the following in the directory that contains the *.tar.gz files
## for file in `ls`; do bash albacore_run.sh ${file} > /path/to/qusb/dir/${file}_qsub.sh; done 
INPUT=$1
OUTPUT=$1
OUTDIR="/short/aq97/mcm106/Etrit_basecalled/"
INDIR="/short/aq97/mcm106/Etrit-aus16-1/"
len=${#1}
PBS="\$PBS_JOBFS"
echo "
#!/bin/bash
#PBS -P aq97
#PBS -q express 
#PBS -l walltime=03:00:00,mem=12GB,ncpus=16,jobfs=12GB

module load albacore/1.2.1

INPUT="$INPUT"
OUTPUT="$OUTPUT"
len="$len"



cd "$PBS"
cp "$INDIR$INPUT" ./
tar -xopzf "$INPUT"
rm -r $INPUT
## these lines need to change to fit the regular naming of the folders that get tar.gz 
read_fast5_basecaller.py -t 16 -i ${INPUT:0:$len-12} -s ${INPUT:0:$len-7}_basecalled -c r95_450bps_linear.cfg -r -o fastq
##read_fast5_basecaller.py -t 16 -i ${INPUT:0:$len-12} -s ${INPUT:0:$len-7}_basecalled -c r95_450bps_linear.cfg -r -o fastq,fast5
cp -r ${INPUT:0:$len-7}_basecalled  $OUTDIR 
rm -r ${INPUT:0:$len-12}


"

### to qsub all the scripts:
### cd /path/to/qusb/dir/
### for file in `ls`; do qsub ${file} ; done