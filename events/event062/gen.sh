lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.11967967967968 --fixed-mass2 10.772492492492493 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000353522.7111273 \
--gps-end-time 1000360722.7111273 \
--d-distr volume \
--min-distance 453.55087970042837e3 --max-distance 453.57087970042835e3 \
--l-distr fixed --longitude -117.51048278808594 --latitude -19.410566329956055 --i-distr uniform \
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
