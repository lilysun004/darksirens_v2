lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.62394394394394 --fixed-mass2 55.06370370370371 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007853856.9502596 \
--gps-end-time 1007861056.9502596 \
--d-distr volume \
--min-distance 1526.0508363513577e3 --max-distance 1526.0708363513577e3 \
--l-distr fixed --longitude 53.892581939697266 --latitude -55.509307861328125 --i-distr uniform \
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
