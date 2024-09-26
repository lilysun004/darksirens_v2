lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.68364364364365 --fixed-mass2 77.7555955955956 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009290157.4413744 \
--gps-end-time 1009297357.4413744 \
--d-distr volume \
--min-distance 3268.1100835378847e3 --max-distance 3268.130083537885e3 \
--l-distr fixed --longitude -167.7845001220703 --latitude 12.549116134643555 --i-distr uniform \
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
