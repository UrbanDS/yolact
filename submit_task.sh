# age: gputest.sh
# Change job name and email address as needed 
#        
# -- our name ---
#$ -N nlp

#$ -S /bin/sh
# Make sure that the .e and .o file arrive in the
#working directory
#$ -cwd
#Merge the standard out and standard error to one file
#$ -j y
# Send mail at submission and completion of script
#$ -m be

# Request a gpu
#$ -q datasci
### #$ -q short

/bin/echo Running on host: `hostname`.
/bin/echo In directory: `pwd`
/bin/echo Starting on: `date`
 
# Load CUDA module
. /opt/modules/init/bash
module load cuda
module load singularity

singularity exec --nv docker://biggreenapple/yolact:latest python ./train.py --num_workers=0 --cuda=True --save_interval=5000 --config=yolact_resnet50_cig_butts_config --validation_size=146 --batch_size=20
