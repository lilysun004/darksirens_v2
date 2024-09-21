lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.933293293293293 --fixed-mass2 20.605645645645644 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000318339.3652891 \
--gps-end-time 1000325539.3652891 \
--d-distr volume \
--min-distance 2230.615760034126e3 --max-distance 2230.6357600341266e3 \
--l-distr fixed --longitude 132.4826202392578 --latitude 61.30944061279297 --i-distr uniform \
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
