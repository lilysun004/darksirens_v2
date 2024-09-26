lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.195195195195193 --fixed-mass2 79.94074074074075 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024599360.9442849 \
--gps-end-time 1024606560.9442849 \
--d-distr volume \
--min-distance 1720.101095889722e3 --max-distance 1720.121095889722e3 \
--l-distr fixed --longitude 51.063655853271484 --latitude -59.64643478393555 --i-distr uniform \
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
