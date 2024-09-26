lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.46562562562563 --fixed-mass2 81.3694894894895 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013162037.3358108 \
--gps-end-time 1013169237.3358108 \
--d-distr volume \
--min-distance 3962.7064942302504e3 --max-distance 3962.726494230251e3 \
--l-distr fixed --longitude 59.60326385498047 --latitude -64.09741973876953 --i-distr uniform \
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
