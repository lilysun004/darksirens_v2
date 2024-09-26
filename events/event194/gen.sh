lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.48996996996997 --fixed-mass2 42.96136136136136 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029771079.9880185 \
--gps-end-time 1029778279.9880185 \
--d-distr volume \
--min-distance 1424.687919329005e3 --max-distance 1424.7079193290049e3 \
--l-distr fixed --longitude 52.923187255859375 --latitude 60.2958869934082 --i-distr uniform \
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
