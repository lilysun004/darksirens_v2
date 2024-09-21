lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.69821821821822 --fixed-mass2 76.07471471471472 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019805809.9081447 \
--gps-end-time 1019813009.9081447 \
--d-distr volume \
--min-distance 2518.6365285381476e3 --max-distance 2518.656528538148e3 \
--l-distr fixed --longitude 3.152688980102539 --latitude -30.04006004333496 --i-distr uniform \
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
