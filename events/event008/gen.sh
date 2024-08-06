lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 57.500980980980984 --fixed-mass2 78.42794794794796 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029302766.8447791 \
--gps-end-time 1029309966.8447791 \
--d-distr volume \
--min-distance 3579.3583582649253e3 --max-distance 3579.3783582649257e3 \
--l-distr fixed --longitude 172.26217651367188 --latitude -43.0576286315918 --i-distr uniform \
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
