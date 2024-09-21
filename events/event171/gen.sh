lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.471671671671672 --fixed-mass2 82.46206206206206 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027304794.0828695 \
--gps-end-time 1027311994.0828695 \
--d-distr volume \
--min-distance 1319.3466206048554e3 --max-distance 1319.3666206048554e3 \
--l-distr fixed --longitude 167.097412109375 --latitude -13.590119361877441 --i-distr uniform \
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
