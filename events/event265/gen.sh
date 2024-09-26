lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.849249249249247 --fixed-mass2 86.16 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016514902.6217508 \
--gps-end-time 1016522102.6217508 \
--d-distr volume \
--min-distance 818.3884533141882e3 --max-distance 818.4084533141881e3 \
--l-distr fixed --longitude -7.64788818359375 --latitude -15.757776260375977 --i-distr uniform \
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
