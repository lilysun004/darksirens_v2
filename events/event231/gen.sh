lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.431511511511516 --fixed-mass2 82.20992992992993 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023835029.6623266 \
--gps-end-time 1023842229.6623266 \
--d-distr volume \
--min-distance 2128.6417016941127e3 --max-distance 2128.661701694113e3 \
--l-distr fixed --longitude -116.37332153320312 --latitude 15.383700370788574 --i-distr uniform \
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
