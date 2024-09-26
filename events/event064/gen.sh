lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.035635635635636 --fixed-mass2 49.93701701701702 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004534915.6497886 \
--gps-end-time 1004542115.6497886 \
--d-distr volume \
--min-distance 3057.513646133617e3 --max-distance 3057.5336461336174e3 \
--l-distr fixed --longitude 85.15106964111328 --latitude 29.424009323120117 --i-distr uniform \
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
