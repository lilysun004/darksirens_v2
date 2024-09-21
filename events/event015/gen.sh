lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.789549549549548 --fixed-mass2 61.19891891891892 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010328037.2534862 \
--gps-end-time 1010335237.2534862 \
--d-distr volume \
--min-distance 1343.706847230343e3 --max-distance 1343.726847230343e3 \
--l-distr fixed --longitude -175.67478942871094 --latitude -81.75489044189453 --i-distr uniform \
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
