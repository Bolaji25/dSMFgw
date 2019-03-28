#! /bin/bash
#SBATCH --mail-user=jennifer.semple@izb.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --job-name="dSMF_Ccall"
#SBATCH --time=1-12:00:00
#SBATCH --cpus-per-task=4
#SBATCH --partition=all
#SBATCH --mem-per-cpu=8G

module add vital-it
module load R/3.5.1
module add UHTS/Analysis/MultiQC/1.7;

# Collect various QC data produced by previous script together
multiqc ./fastQC

# Call methylation and do plots
source ./varSettings.sh

if [[ "$dataType" == gw ]]
then
	Rscript dSMFseqAnalysis1_gw_aln.R ${genomefile}
	echo "processing genome wide library"
elif [[ "$dataType" == amp ]]
then
	Rscript dSMFseqAnalysis1_amp_aln.R ${genomefile}
	echo "processing amplicon library"
else
	echo "ERROR: dataType in varSettings.sh must be either "amp" (amplicon library) or "gw" (genome-wide library)"
fi


