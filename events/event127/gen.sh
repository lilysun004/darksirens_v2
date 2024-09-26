lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 10.016096096096096 --fixed-mass2 60.35847847847848 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029165766.7948985 \
--gps-end-time 1029172966.7948985 \
--d-distr volume \
--min-distance 1257.361957921896e3 --max-distance 1257.381957921896e3 \
--l-distr fixed --longitude 14.379339218139648 --latitude -34.55530548095703 --i-distr uniform \
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
