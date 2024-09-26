lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 44.05393393393393 --fixed-mass2 47.91995995995996 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025988677.0437001 \
--gps-end-time 1025995877.0437001 \
--d-distr volume \
--min-distance 5977.906915849708e3 --max-distance 5977.926915849708e3 \
--l-distr fixed --longitude -33.70849609375 --latitude -32.3964729309082 --i-distr uniform \
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
