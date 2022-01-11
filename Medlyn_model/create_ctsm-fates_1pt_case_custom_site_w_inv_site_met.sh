#!/bin/sh
# =======================================================================================
#
# This script will create, setup and build a single-site simulation at
# a desired site using previously generated GSWP3 single-site drivers
#
#
# Example usage with SLZ inv and met:
#./create_ctsm-fates_1pt_case_custom_site_w_inv_site_met.sh --case_root=/data2/Model_Output/ctsm_runs/single_point/serbinsh \
#--site_name=PA-SLZ_site --inventory=/data/Model_Data/cesm_input_datasets/single_point/PA-SLZ_site/Inventory/slz_onepft_inv_file_list.txt \
#--start_year='1999-01-01' --num_years=21 --run_type=startup --met_start=2008 --met_end=2016 \
#--resolution=0.9x1.25
# 
# Example usage with SLZ inv and met. Define specific/custom FATES parameter file:
#./create_ctsm-fates_1pt_case_custom_site_w_inv_site_met.sh --case_root=/data2/Model_Output/ctsm_runs/single_point/serbinsh \
#--site_name=PA-SLZ_site --inventory=/data/Model_Data/cesm_input_datasets/single_point/PA-SLZ_site/Inventory/slz_onepft_inv_file_list.txt \
#--fates_param=/data/sserbin/Modeling/ctsm_fates/parameter_files/fates_params_api.8.1.0_12pft_c200103.nc --start_year='1999-01-01' \
#--num_years=21 --run_type=startup --met_start=2008 --met_end=2016 --resolution=0.9x1.25
#
#
# NOTE: presently SLZ met is missing 2017 December data? 
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
ctsm_fates_source="${ctsm_fates_source:-/data2/qli1/ctsm_fates/ctsm_fates_master_medlyn}" #check the model codes
case_root="${case_root:-/data2/Model_Output/ctsm_runs/single_point/qli1/medlyn/sitecomp}"
site_name="${site_name:-PA-SLZ_site}"
inventory="${inventory:-/data/Model_Data/cesm_input_datasets/single_point/PA-SLZ_site/Inventory/slz_onepft_inv_file_list.txt}"
clm5_param="${clm5_param:-clm5_params.c171117.nc}"
fates_param="${fates_param:-fates_params_medlyn_lqy.nc}"  # !!this may not be a good idea as this file can change!! may need to define explicitly
start_year="${start_year:-2008-01-01}"
num_years="${num_years:-9}"
rtype="${rtype:-startup}"
met_start="${met_start:-2008}"
met_end="${met_end:-2016}"
resolution="${resolution:-0.9x1.25}"

# show options
datm_data_root=/data/Model_Data/cesm_input_datasets/single_point/
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
#export MACH=${HOSTNAME}							                         # machine hostname
export MACH=modex
export RES=CLM_USRDAT							                         # 1pt
#export COMP=2000_DATM%GSWP3v1_CLM50%BGC-CROP_SICE_SOCN_MOSART_SGLC_SWAV # compset
export COMP=I2000Clm50FatesGs
export CASEROOT=${case_root}						                     # Container/model output location.  Can be redirected to a different location on the host
export date_var=$(date +%s)						                         # auto info tag
export CASE_NAME=${CASEROOT}/${MODEL_VERSION}_${date_var}_${site_name}	 # Output directory name
# =======================================================================================


# =======================================================================================
## !!! THIS PROBABLY NEEDS TO BE A MORE GENERAL LOCATION !!!
# Define CLM5/FATES parameter file locations here:
export CLM5_PARAM_FILE_PATH=/data/qli1/Modeling/ctsm_fates/parameter_files/
export CLM5_PARAM_FILE=${clm5_param}
export FATES_PARAM_FILE_PATH=/data2/qli1/paramfile/
export FATES_PARAM_FILE=${fates_param}
# =======================================================================================


# =======================================================================================
# Setup forcing data paths and files:
# Define forcing and surfice file data for run:
export datmdata_dir=${datm_data_root}/${site_name}
echo "DATM forcing data directory:"
echo ${datmdata_dir}

#pattern=${datmdata_dir}/"domain.lnd.360x720_*"
#datm_domain_lnd=( $pattern )
#echo "DATM land domain file:"
#echo "${datm_domain_lnd[0]}"
#export CLM5_DATM_DOMAIN_LND=${datm_domain_lnd[0]}

pattern=${datmdata_dir}/"domain.lnd.fv${resolution}*"
domain_lnd=( $pattern )
domain_lnd_file="$(basename $domain_lnd)"
echo "Land domain file:"
echo "${domain_lnd_file[0]}"
export CLM5_USRDAT_DOMAIN=${domain_lnd_file[0]}

pattern=${datmdata_dir}/"surfdata_${resolution}_16pfts*"
surfdata=( $pattern )
surfdata_file="$(basename $surfdata)"
echo "Surface file:"
echo "${surfdata_file[0]}"
export CLM5_SURFDAT=${surfdata_file[0]}
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
./xmlchange CCSM_CO2_PPMV=403.3


# domain options
./xmlchange -a CLM_CONFIG_OPTS='-nofire'
./xmlchange ATM_DOMAIN_FILE=${CLM5_USRDAT_DOMAIN}
./xmlchange LND_DOMAIN_FILE=${CLM5_USRDAT_DOMAIN}
./xmlchange ATM_DOMAIN_PATH=${datmdata_dir}
./xmlchange LND_DOMAIN_PATH=${datmdata_dir}
./xmlchange DATM_MODE=CLM1PT
./xmlchange CLM_USRDAT_NAME=${site_name}
./xmlchange MOSART_MODE=NULL

# met options
./xmlchange --id DATM_CLMNCEP_YR_START --val ${met_start}
./xmlchange --id DATM_CLMNCEP_YR_END --val ${met_end}

# location of forcing and surface files. This is relative to within the container after mapping the external data dir to /data
./xmlchange DIN_LOC_ROOT_CLMFORC=${datm_data_root}
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

export CLM5_SURFDAT_FULL_PATH=${datmdata_dir}/${CLM5_SURFDAT}
cat >> user_nl_clm <<EOF
fsurdat = '${CLM5_SURFDAT_FULL_PATH}'
hist_empty_htapes = .true.
use_fates_inventory_init = .true.
fates_inventory_ctrl_filename = '${inventory}'
hist_fincl1       = 'NEP','PCO2','BTRAN','GPP','NPP','AGB','TOTSOMC','TLAI','ELAI','TG',\
'TSOI','TSOI_10CM','H2OSOI','SMP','TV','QVEGT','QVEGE','FCTR','Qle','Qh','FSH',\
'EFLX_LH_TOT','AR','FSH_G','FSH_V','FCEV','FGEV','QFLX_EVAP_GRND','QFLX_EVAP_VEG','QFLX_EVAP_TOT',\
'QSOIL','EFLX_LH_TOT_R','EFLX_SOIL_GRND','Rnet','ALBD','AR','HR','Qstor','Qtau','HR','ED_biomass',\
'ED_bleaf','ED_balive','DDBH_SCPF','BA_SCPF','NPLANT_SCPF','M1_SCPF','M2_SCPF','M3_SCPF','M4_SCPF',\
'M5_SCPF','M6_SCPF','GPP_BY_AGE','PATCH_AREA_BY_AGE','CANOPY_AREA_BY_AGE','BA_SCLS',\
'NPLANT_CANOPY_SCLS','NPLANT_UNDERSTORY_SCLS','DDBH_CANOPY_SCLS','DDBH_UNDERSTORY_SCLS',\
'MORTALITY_CANOPY_SCLS','MORTALITY_UNDERSTORY_SCLS','C_STOMATA','C_LBLAYER','LAISUN_TOP_CAN',\
'LAISHA_TOP_CAN','NET_C_UPTAKE_CNLF','WIND','ZBOT','FSDS','RH','TBOT','PBOT','QBOT','RAIN','FLDS',\
'STOMATAL_COND_CNLF','CROWNAREA_CNLF','PARSUN_Z_CAN','PARSHA_Z_CAN','GPP_CANOPY_SCPF'
hist_mfilt             = 8760
hist_nhtfrq            = -1
co2_ppmv               = 403.3
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
cp run/datm.streams.txt.CLM1PT.CLM_USRDAT user_datm.streams.txt.CLM1PT.CLM_USRDAT
`sed -i '/FLDS/d' user_datm.streams.txt.CLM1PT.CLM_USRDAT`

echo "*** Build case ***"
echo " "
./case.build

echo "*** Finished building new case in CASE: ${CASE_NAME}"

# =============================================================================
#### EOF
