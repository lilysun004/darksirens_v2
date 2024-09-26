lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 55.483923923923925 --fixed-mass2 25.73233233233233 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023583245.946221 \
--gps-end-time 1023590445.946221 \
--d-distr volume \
--min-distance 3135.971204798668e3 --max-distance 3135.9912047986686e3 \
--l-distr fixed --longitude -126.0916748046875 --latitude 33.04701614379883 --i-distr uniform \
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
