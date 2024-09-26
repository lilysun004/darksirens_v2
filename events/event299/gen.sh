lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.88336336336336 --fixed-mass2 46.491211211211215 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003981457.8170565 \
--gps-end-time 1003988657.8170565 \
--d-distr volume \
--min-distance 2089.5191845333097e3 --max-distance 2089.53918453331e3 \
--l-distr fixed --longitude 42.44353103637695 --latitude -42.24613952636719 --i-distr uniform \
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
