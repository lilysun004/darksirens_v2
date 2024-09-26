lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 14.806606606606607 --fixed-mass2 41.364524524524526 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022356218.2958835 \
--gps-end-time 1022363418.2958835 \
--d-distr volume \
--min-distance 1140.0568655744923e3 --max-distance 1140.0768655744923e3 \
--l-distr fixed --longitude 9.773445129394531 --latitude -75.07300567626953 --i-distr uniform \
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
