lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 73.38530530530531 --fixed-mass2 45.56672672672673 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030741394.5090201 \
--gps-end-time 1030748594.5090201 \
--d-distr volume \
--min-distance 2996.6197973611906e3 --max-distance 2996.639797361191e3 \
--l-distr fixed --longitude -26.980224609375 --latitude -9.842240333557129 --i-distr uniform \
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
