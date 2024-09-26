lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.57401401401402 --fixed-mass2 53.88708708708709 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002690230.6255994 \
--gps-end-time 1002697430.6255994 \
--d-distr volume \
--min-distance 2343.0558250560057e3 --max-distance 2343.075825056006e3 \
--l-distr fixed --longitude -143.2298583984375 --latitude -5.0176005363464355 --i-distr uniform \
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
