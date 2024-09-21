lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.403443443443443 --fixed-mass2 28.673873873873873 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028874544.8659012 \
--gps-end-time 1028881744.8659012 \
--d-distr volume \
--min-distance 1524.925773931986e3 --max-distance 1524.945773931986e3 \
--l-distr fixed --longitude -42.464935302734375 --latitude 42.5446891784668 --i-distr uniform \
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
