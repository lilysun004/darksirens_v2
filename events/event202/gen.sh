lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.62998998998999 --fixed-mass2 36.65805805805806 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009381701.2980965 \
--gps-end-time 1009388901.2980965 \
--d-distr volume \
--min-distance 1252.0886615142285e3 --max-distance 1252.1086615142285e3 \
--l-distr fixed --longitude -7.063385009765625 --latitude 79.74097442626953 --i-distr uniform \
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
