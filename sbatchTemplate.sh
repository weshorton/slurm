#!/bin/bash

#SBATCH --partition          exacloud                # partition (queue)
#SBATCH --nodes              1                       # number of nodes (step 1)
#SBATCH --ntasks             10                       # number of "tasks" to be allocated for the job
#SBATCH --ntasks-per-core    1                       # Max number of "tasks" per core. (Value of 1 makes tasks ~ cores)
#SBATCH --cpus-per-task      1                       # Set if you know a task requires multiple processors
#SBATCH --mem-per-cpu        8000                    # Memory required per allocated CPU (mutually exclusive with mem)
##SBATCH --mem                16000                   # memory pool for each node
#SBATCH --time               0-24:00                 # time (D-HH:MM)
#SBATCH --output             mytask_%A_%a.out        # Standard output
#SBATCH --error              mytask_%A_%a.err        # Standard error
#SBATCH --array              1-10                    # sets number of jobs in array

### SET I/O VARIABLES

IN=$data/path/to/inDir             # Directory containing all input files. Should be one job per file
OUT=$data/path/to/outDir           # Directory where output files should be written
LOG=$data/path/to/logDir           # Directory where log files should be moved to
MYBIN=/path/to/executable          # Path to shell script or command-line executable that will be used

### Record slurm info

echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
echo "SLURM_JOB_NODELIST: " $SLURM_JOB_NODELIST
echo "SLURM_CPUS_ON_NODE: " $SLURM_CPUS_ON_NODE
echo "SLURM_CPUS_PER_TASK: " $SLURM_CPUS_PER_TASK
echo "SLURM_JOB_CPUS_PER_NODE: " $SLURM_JOB_CPUS_PER_NODE
echo "SLURM_MEM_PER_CPU: " $SLURM_MEM_PER_CPU
echo "SLURM_MEM_PER_NODE: " $SLURM_MEM_PER_NODE
echo "SLURM_NTASKS: " $SLURM_NTASKS
echo "SLURM_NTASKS_PER_CORE " $SLURM_NTASKS_PER_CORE
echo "SLURM_NTASKS_PER_NODE " $SLURM_NTASKS_PER_NODE
echo "SLURM_TASKS_PER_NODE " $SLURM_TASKS_PER_NODE

# create array of file names in this location (input files)
# This only works if the output goes to a new location...if you're writing output to same directory use other method
#CURRFILE=`ls $IN | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}'`

# Alternative method
TODO=$data/path/to/todoFile
CURRFILE=`awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}' $TODO`

# Execute
#$MYBIN $IN/$CURRFILE $OUT


