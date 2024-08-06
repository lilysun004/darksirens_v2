lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 60.862742742742746 --fixed-mass2 78.93221221221222 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005672231.9392508 \
--gps-end-time 1005679431.9392508 \
--d-distr volume \
--min-distance 2069.862422115352e3 --max-distance 2069.8824221153523e3 \
--l-distr fixed --longitude 142.20753479003906 --latitude 51.82120132446289 --i-distr uniform \
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
