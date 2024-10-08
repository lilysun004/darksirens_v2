lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.15131131131131 --fixed-mass2 77.7555955955956 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022590014.0767694 \
--gps-end-time 1022597214.0767694 \
--d-distr volume \
--min-distance 1092.8347531821757e3 --max-distance 1092.8547531821757e3 \
--l-distr fixed --longitude 142.54867553710938 --latitude -74.04903411865234 --i-distr uniform \
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
