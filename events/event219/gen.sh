lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.884604604604604 --fixed-mass2 64.64472472472472 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027835518.8012153 \
--gps-end-time 1027842718.8012153 \
--d-distr volume \
--min-distance 2867.9433012934865e3 --max-distance 2867.963301293487e3 \
--l-distr fixed --longitude -127.10336303710938 --latitude -10.873154640197754 --i-distr uniform \
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
