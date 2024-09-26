lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.538658658658658 --fixed-mass2 71.2842042042042 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012800278.1215473 \
--gps-end-time 1012807478.1215473 \
--d-distr volume \
--min-distance 1430.601834142796e3 --max-distance 1430.621834142796e3 \
--l-distr fixed --longitude 101.0186538696289 --latitude -11.340335845947266 --i-distr uniform \
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
