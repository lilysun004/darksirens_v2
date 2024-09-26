lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.73233233233233 --fixed-mass2 53.718998998999005 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020803678.1106843 \
--gps-end-time 1020810878.1106843 \
--d-distr volume \
--min-distance 3321.88857983693e3 --max-distance 3321.9085798369306e3 \
--l-distr fixed --longitude -162.55422973632812 --latitude -20.678043365478516 --i-distr uniform \
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
