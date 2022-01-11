#!/bin/sh
# =======================================================================================
#
# This script will create, setup and build a single-site simulation at
# a desired site using previously generated GSWP3 single-site drivers
#
#
# Example usage:
#ctsm-fates version: xxxxxx 
# ./create_ctsm-fates_1pt_case_custom_site.sh --case_root=/data2/Model_Output/ctsm_runs/single_point/serbinsh \
#--site_name=PA-Bar --inventory=/data/Model_Data/cesm_input_datasets/single_point/PA-Bar_site/Inventory/bci_onepft_inv_file_list.txt \
#--start_year='1901-01-01' --num_years=150 --run_type=startup --met_start=1901 --met_end=2010 --resolution=0.9x1.25
# 
# Defaults: 
# ctsm_fates_source: /data/sserbin/Modeling/ctsm_fates/ctsm_fates_master
# clm5_param: 
# fates_param:
#
#
#
# Created by:
# Shawn Serbin (Fri Feb 7 2020)
# 
# =======================================================================================


# =======================================================================================
echo "Current directory: ${PWD}"
# script options
for i in "$@"
do
case $i in
    -cf=*|--ctsm_fates_source=*)
    ctsm_fates_source="${i#*=}"
    shift
    ;;
    -cr=*|--case_root=*)
    case_root="${i#*=}"
    shift
    ;;
    -sn=*|--site_name=*)
    site_name="${i#*=}"
    shift
    ;;
    -iv=*|--inventory=*)
    inventory="${i#*=}"
    shift
    ;;
    -cp=*|--clm5_param=*)
    clm5_param="${i#*=}"
    shift
    ;;
    -fp=*|--fates_param=*)
    fates_param="${i#*=}"
    shift
    ;;
    -sy=*|--start_year=*)
    start_year="${i#*=}"
    shift
    ;;
    -ny=*|--num_years=*)
    num_years="${i#*=}"
    shift
    ;;
    -rt=*|--run_type=*)
    run_type="${i#*=}"
    shift
    ;;
    -mets=*|--met_start=*)
    met_start="${i#*=}"
    shift
    ;;
    -mete=*|--met_end=*)
    met_end="${i#*=}"
    shift
    ;;
    -res=*|--resolution=*)
    resolution="${i#*=}"
    shift # past argument with no value
    ;;
    *)
          # unknown option
    ;;
esac
done

# check for missing inputs and set defaults
#ctsm_fates_source="${ctsm_fates_source:-/data/sserbin/Modeling/ctsm_fates/ctsm_fates_master}"
ctsm_fates_source="${ctsm_fates_source:-/data2/qli1/ctsm_fates/ctsm_fates_master_medlyn}"
case_root="${case_root:-/data2/Model_Output/ctsm_runs/single_point/qli1/medlyn/sensitivity0815/Precip}"
site_name="${site_name:-PA-SLZ}"
inventory="${inventory:-/data/Model_Data/cesm_input_datasets/single_point/PA-SLZ_site/Inventory/slz_onepft_inv_file_list.txt}"
clm5_param="${clm5_param:-clm5_params.c171117.nc}"
fates_param="${fates_param:-fates_params_medlyn_lqy.nc}"
#datm_data="${datm_data:-/data}"  # maybe later we make this a user-defined option, but for now hard-code
start_year="${start_year:-1965-01-01}"
num_years="${num_years:-49}"
rtype="${rtype:-startup}"
met_start="${met_start:-1965}"
met_end="${met_end:-2014}"
resolution="${resolution:-0.9x1.25}"

# show options
datm_data_root=/data/Model_Data/cesm_input_datasets/single_point_synthetic_met/${site_name}/Precip_50yr
cesm_data_root=/data/Model_Data/cesm_input_datasets
echo "CTSM-FATES source = ${ctsm_fates_source}"
echo "CASEROOT location = ${case_root}"
echo "Site Name = ${site_name}"
echo "Inventory source = ${inventory}"
echo "CLM5 parameter file = ${clm5_param}"
echo "FATES parameter file = ${fates_param}"
echo "DATM data source = ${datm_data_root}"
echo "Model simulation start year  = ${start_year}"
echo "Number of simulation years  = ${num_years}"
echo "Run type = ${rtype}"
echo "DATM_CLMNCEP_YR_START: "${met_start}
echo "DATM_CLMNCEP_YR_END: "${met_end}
echo "Resolution: "${resolution}

# =======================================================================================


# =======================================================================================
# Setup simulation case
export SITE_NAME=${site_name}							                 # which site?
export MODEL_SOURCE=${ctsm_fates_source}		                         # don't change, location in the container
export MODEL_VERSION=CLM5-FATES						                     # info tag
export CLM_HASH=`(cd ${MODEL_SOURCE};git log -n 1 --pretty=%h)`		     # info tag
export CIME_MODEL=cesm							                         # which CIME model
#export MACH=${HOSTNAME}
export MACH=modex							                         # machine hostname
export RES=CLM_USRDAT							                         # 1pt
#export COMP=2000_DATM%GSWP3v1_CLM50%BGC-CROP_SICE_SOCN_MOSART_SGLC_SWAV # compset
export COMP=I2000Clm50FatesGs
export CASEROOT=${case_root}						                     # Container/model output location.  Can be redirected to a different location on the host
export date_var=$(date +%s)						                         # auto info tag
export CASE_NAME=${CASEROOT}/${MODEL_VERSION}_${date_var}_${site_name}	 # Output directory name
# =======================================================================================


# =======================================================================================
# Define CLM5/FATES parameter files here:
export CLM5_PARAM_FILE_PATH=/data/qli1/Modeling/ctsm_fates/parameter_files/
export CLM5_PARAM_FILE=${clm5_param}
export FATES_PARAM_FILE_PATH=/data2/qli1/paramfile/
export FATES_PARAM_FILE=${fates_param}
# =======================================================================================


# =======================================================================================
# Setup forcing data paths and files:
# Define forcing and surfice file data for run:
export datmdata_dir=${datm_data_root}/datmdata/atm_forcing.datm7.GSWP3.0.5d.v1.c170516
echo "DATM forcing data directory:"
echo ${datmdata_dir}

pattern=${datm_data_root}/"domain.lnd.360x720_"
datm_domain_lnd=( $pattern )
echo "DATM land domain file:"
echo "${datm_domain_lnd[0]}"
export CLM5_DATM_DOMAIN_LND=${datm_domain_lnd[0]}

pattern=${datm_data_root}/"domain.lnd.fv${resolution}*"
domain_lnd=( $pattern )
echo "Land domain file:"
echo "${domain_lnd[0]}"
export CLM5_USRDAT_DOMAIN=${domain_lnd[0]}

pattern=${datm_data_root}/"surfdata_${resolution}_16pfts*"
surfdata=( $pattern )
echo "Surface file:"
echo "${surfdata[0]}"
export CLM5_SURFDAT=${surfdata[0]}
# =======================================================================================


# =======================================================================================
# Setup case:
rm -rf ${CASE_NAME}

echo "*** start: ${date_var} "
echo "*** Building CASE: ${CASE_NAME} "
echo "Running with CTSM location: "${MODEL_SOURCE}
cd ${MODEL_SOURCE}/cime/scripts/

# create case
./create_newcase --case ${CASE_NAME} --res ${RES} --compset ${COMP} --mach ${MACH} --run-unsupported

echo "*** Switching directory to CASE: ${CASE_NAME} "
echo "Build options: res=${RES}; compset=${COMP}; mach ${MACH}"
cd ${CASE_NAME}
echo ${PWD}

# Copy parameter files to case
echo "*** Copy CLM5 parameter file ***"
echo ${CLM5_PARAM_FILE_PATH}/${CLM5_PARAM_FILE}
echo " "
cp ${CLM5_PARAM_FILE_PATH}/${CLM5_PARAM_FILE} .

echo "*** Copy FATES parameter file ***"
echo ${FATES_PARAM_FILE_PATH}/${FATES_PARAM_FILE}
echo " "
cp ${FATES_PARAM_FILE_PATH}/${FATES_PARAM_FILE} .
# =======================================================================================


# =======================================================================================
## modify XML options
echo "*** Modifying xmls  ***"

./xmlchange RUN_TYPE=${rtype}
./xmlchange CALENDAR=GREGORIAN
./xmlchange --file env_run.xml --id PIO_DEBUG_LEVEL --val 0
./xmlchange RUN_STARTDATE=${start_year}
./xmlchange --id STOP_N --val ${num_years}
./xmlchange --id STOP_OPTION --val nyears
./xmlchange --id REST_N --val 1
./xmlchange --id REST_OPTION --val nyears
./xmlchange --id CLM_FORCE_COLDSTART --val on
./xmlchange --id RESUBMIT --val 0
./xmlchange --file env_run.xml --id DOUT_S_SAVE_INTERIM_RESTART_FILES --val TRUE
./xmlchange --file env_run.xml --id DOUT_S --val TRUE
./xmlchange --file env_run.xml --id DOUT_S_ROOT --val ${CASE_NAME}/history
./xmlchange --file env_run.xml --id RUNDIR --val ${CASE_NAME}/run
./xmlchange --file env_build.xml --id EXEROOT --val ${CASE_NAME}/bld
./xmlchange JOB_WALLCLOCK_TIME=48:00:00
./xmlchange CCSM_CO2_PPMV=400

# domain options
./xmlchange -a CLM_CONFIG_OPTS='-nofire'
./xmlchange ATM_DOMAIN_FILE=${CLM5_USRDAT_DOMAIN}
./xmlchange LND_DOMAIN_FILE=${CLM5_USRDAT_DOMAIN}
./xmlchange ATM_DOMAIN_PATH=${datm_data_root}
./xmlchange LND_DOMAIN_PATH=${datm_data_root}
./xmlchange CLM_USRDAT_NAME=${site_name}
./xmlchange MOSART_MODE=NULL

# met options
./xmlchange --id DATM_CLMNCEP_YR_START --val ${met_start}
./xmlchange --id DATM_CLMNCEP_YR_END --val ${met_end}

# location of forcing and surface files. This is relative to within the container after mapping the external data dir to /data
./xmlchange DIN_LOC_ROOT_CLMFORC=${datm_data_root}/datmdata
./xmlchange DIN_LOC_ROOT=${cesm_data_root}

# turn off debug
./xmlchange DEBUG=FALSE
./xmlchange INFO_DBUG=0

# Optimize PE layout for run
./xmlchange NTASKS_ATM=1,ROOTPE_ATM=0,NTHRDS_ATM=1
./xmlchange NTASKS_CPL=1,ROOTPE_CPL=1,NTHRDS_CPL=1
./xmlchange NTASKS_LND=1,ROOTPE_LND=3,NTHRDS_LND=1
./xmlchange NTASKS_OCN=1,ROOTPE_OCN=1,NTHRDS_OCN=1
./xmlchange NTASKS_ICE=1,ROOTPE_ICE=1,NTHRDS_ICE=1
./xmlchange NTASKS_GLC=1,ROOTPE_GLC=1,NTHRDS_GLC=1
./xmlchange NTASKS_ROF=1,ROOTPE_ROF=1,NTHRDS_ROF=1
./xmlchange NTASKS_WAV=1,ROOTPE_WAV=1,NTHRDS_WAV=1
./xmlchange NTASKS_ESP=1,ROOTPE_ESP=1,NTHRDS_ESP=1

# Set run location to case dir
./xmlchange --file env_build.xml --id CIME_OUTPUT_ROOT --val ${CASE_NAME}
# =======================================================================================


# =======================================================================================
echo "*** Update user_nl_clm ***"
echo " "

# temporarily pulling this out from below (i.e cat >> user_nl_clm <<EOF)
# fsurdat = '${CLM5_SURFDAT}'
# update user_nl_clm
## !!! need to add use_fates_inventory_init = .true.
## AND
## fates_inventory_ctrl_filename = '${inventory}'
cat >> user_nl_clm <<EOF
fsurdat = '${CLM5_SURFDAT}'
hist_empty_htapes = .true.
use_fates_inventory_init = .true.
fates_inventory_ctrl_filename = '${inventory}'
hist_fincl1       = 'GPP','QVEGT', 'QVEGE','TV', 'C_STOMATA','TBOT','QBOT','RAIN','FSDS','RH','RH2M','NPLANT_SCAG','PCO2','NPLANT_SCAGPFT','NPLANT_SCPF','NPLANT_SCLS','NET_C_UPTAKE_CNLF','AGB','STOMATAL_COND_CNLF','CROWNAREA_CNLF'
hist_mfilt             = 8760
hist_nhtfrq            = -1
EOF

echo "*** Point to CLM5 and FATES param files in case directory ***"
echo "${CASE_NAME}/${CLM5_PARAM_FILE}"
echo "${CASE_NAME}/${FATES_PARAM_FILE}"
echo " "
cat >> user_nl_clm <<EOF
paramfile = "${CASE_NAME}/${CLM5_PARAM_FILE}"
fates_paramfile = "${CASE_NAME}/${FATES_PARAM_FILE}"
EOF

## define met params
echo "*** Update met forcing options ***"
echo " "
cat >> user_nl_datm <<EOF
mapalgo = 'nn', 'nn', 'nn'
taxmode = "cycle", "cycle", "cycle"
EOF

#./cesm_setup
echo "*** Running case.setup ***"
echo " "
./case.setup

echo "*** Run preview_namelists ***"
echo " "
./preview_namelists

echo "*** Build case ***"
echo " "
./case.build

echo "*** Finished building new case in CASE: ${CASE_NAME}"

# =============================================================================
#### EOF
