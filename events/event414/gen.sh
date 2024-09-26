lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.866306306306306 --fixed-mass2 50.609369369369375 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027706119.5408337 \
--gps-end-time 1027713319.5408337 \
--d-distr volume \
--min-distance 3199.1813242297544e3 --max-distance 3199.201324229755e3 \
--l-distr fixed --longitude 99.25759887695312 --latitude 30.218149185180664 --i-distr uniform \
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
