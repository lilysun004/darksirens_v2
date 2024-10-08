lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.69821821821822 --fixed-mass2 42.289009009009014 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007674647.0369997 \
--gps-end-time 1007681847.0369997 \
--d-distr volume \
--min-distance 1224.045647958314e3 --max-distance 1224.065647958314e3 \
--l-distr fixed --longitude -77.60552978515625 --latitude 33.5800895690918 --i-distr uniform \
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
