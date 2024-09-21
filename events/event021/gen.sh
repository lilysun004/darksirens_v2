lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.16108108108108 --fixed-mass2 54.30730730730731 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009266446.9012121 \
--gps-end-time 1009273646.9012121 \
--d-distr volume \
--min-distance 1767.1218486351697e3 --max-distance 1767.1418486351697e3 \
--l-distr fixed --longitude 70.8677749633789 --latitude -8.181357383728027 --i-distr uniform \
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
