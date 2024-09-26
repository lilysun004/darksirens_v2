lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.243883883883885 --fixed-mass2 62.543623623623624 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014081765.918246 \
--gps-end-time 1014088965.918246 \
--d-distr volume \
--min-distance 2607.9399168109717e3 --max-distance 2607.959916810972e3 \
--l-distr fixed --longitude 102.74844360351562 --latitude 27.618152618408203 --i-distr uniform \
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
