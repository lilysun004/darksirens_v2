lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.96988988988989 --fixed-mass2 77.50346346346346 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022358401.5198663 \
--gps-end-time 1022365601.5198663 \
--d-distr volume \
--min-distance 3751.8935365491357e3 --max-distance 3751.913536549136e3 \
--l-distr fixed --longitude 144.58950805664062 --latitude 18.535062789916992 --i-distr uniform \
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
