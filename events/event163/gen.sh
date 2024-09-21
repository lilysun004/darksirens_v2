lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.88336336336336 --fixed-mass2 71.20016016016017 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014282311.6330211 \
--gps-end-time 1014289511.6330211 \
--d-distr volume \
--min-distance 3069.9901185094436e3 --max-distance 3070.010118509444e3 \
--l-distr fixed --longitude -31.277252197265625 --latitude -52.58495330810547 --i-distr uniform \
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
