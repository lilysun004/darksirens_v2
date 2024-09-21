lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.16108108108108 --fixed-mass2 70.27567567567569 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015597782.4187628 \
--gps-end-time 1015604982.4187628 \
--d-distr volume \
--min-distance 2082.766996829999e3 --max-distance 2082.786996829999e3 \
--l-distr fixed --longitude 62.543701171875 --latitude 8.93358325958252 --i-distr uniform \
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
