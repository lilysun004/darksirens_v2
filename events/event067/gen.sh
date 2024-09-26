lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 2.7883083083083084 --fixed-mass2 31.95159159159159 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017725391.7890835 \
--gps-end-time 1017732591.7890835 \
--d-distr volume \
--min-distance 243.7640868616132e3 --max-distance 243.7840868616132e3 \
--l-distr fixed --longitude 93.06826782226562 --latitude -11.717206954956055 --i-distr uniform \
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
