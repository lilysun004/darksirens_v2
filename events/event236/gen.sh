lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.84196196196196 --fixed-mass2 6.654334334334335 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011298999.2071801 \
--gps-end-time 1011306199.2071801 \
--d-distr volume \
--min-distance 330.57710857340527e3 --max-distance 330.59710857340525e3 \
--l-distr fixed --longitude 37.4225959777832 --latitude -22.619007110595703 --i-distr uniform \
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
