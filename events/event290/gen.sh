lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.874834834834836 --fixed-mass2 73.13317317317318 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009720649.9181347 \
--gps-end-time 1009727849.9181347 \
--d-distr volume \
--min-distance 2607.4919097695874e3 --max-distance 2607.511909769588e3 \
--l-distr fixed --longitude 5.2978363037109375 --latitude -25.503786087036133 --i-distr uniform \
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
