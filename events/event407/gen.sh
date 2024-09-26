lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.15983983983984 --fixed-mass2 48.508268268268274 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030785110.5149595 \
--gps-end-time 1030792310.5149595 \
--d-distr volume \
--min-distance 861.4909786598271e3 --max-distance 861.5109786598271e3 \
--l-distr fixed --longitude 147.62252807617188 --latitude 35.364810943603516 --i-distr uniform \
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
