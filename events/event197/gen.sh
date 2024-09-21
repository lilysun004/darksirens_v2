lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 41.53261261261262 --fixed-mass2 58.34142142142142 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028147061.5795845 \
--gps-end-time 1028154261.5795845 \
--d-distr volume \
--min-distance 5342.8885612215845e3 --max-distance 5342.908561221585e3 \
--l-distr fixed --longitude 163.7178497314453 --latitude 33.204280853271484 --i-distr uniform \
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
