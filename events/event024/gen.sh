lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 44.97841841841842 --fixed-mass2 54.475395395395395 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005439020.7750218 \
--gps-end-time 1005446220.7750218 \
--d-distr volume \
--min-distance 2152.167145948687e3 --max-distance 2152.1871459486874e3 \
--l-distr fixed --longitude -107.9775390625 --latitude 30.701948165893555 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
