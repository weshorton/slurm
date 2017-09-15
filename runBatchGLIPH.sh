#!/usr/bin/sh

#SBATCH --partition		exacloud
#SBATCH --nodes			1
#SBATCH --ntasks		1
#SBATCH --ntasks-per-core	1
#SBATCH --cpus-per-task		1
#SBATCH --mem-per-cpu		16000
#SBATCH --output		gliph-%j.out
#SBATCH --error			gliph-%j.err

IN=$data/gliph/clones
OUT=$data/gliph/results
DB=$lustre/myApps/gliph/gliph/db/murineMammaryNaive.fa
LOG=$log/gliph/run
TODO=$data/gliph/todo/gliphToDo.txt

### Get specific file to run
CURRFILE=`awk -v line=1 '{if (NR == line) print $0}' $TODO`

echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_JOB_NODELIST: " $SLURM_JOB_NODELIST
echo "SLURM_CPUS_ON_NODE: " $SLURM_CPUS_ON_NODE
echo "Current file: " $CURRFILE

gliph-group-discovery.pl --tcr $IN/$CURRFILE --refdb=$DB

