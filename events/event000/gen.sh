lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 15.563003003003004 --fixed-mass2 77.50346346346346 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029514993.8434018 \
--gps-end-time 1029522193.8434018 \
--d-distr volume \
--min-distance 1275.2490878039823e3 --max-distance 1275.2690878039823e3 \
--l-distr fixed --longitude 101.06165313720703 --latitude 51.20772171020508 --i-distr uniform \
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
