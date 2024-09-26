lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.589829829829828 --fixed-mass2 26.74086086086086 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007672227.8505542 \
--gps-end-time 1007679427.8505542 \
--d-distr volume \
--min-distance 1241.9284472226516e3 --max-distance 1241.9484472226516e3 \
--l-distr fixed --longitude 158.60057067871094 --latitude 8.114599227905273 --i-distr uniform \
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
