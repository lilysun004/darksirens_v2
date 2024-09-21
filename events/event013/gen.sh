lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.40592592592593 --fixed-mass2 64.9809009009009 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006865385.0447252 \
--gps-end-time 1006872585.0447252 \
--d-distr volume \
--min-distance 4754.528579943275e3 --max-distance 4754.548579943275e3 \
--l-distr fixed --longitude 127.15973663330078 --latitude 47.29605484008789 --i-distr uniform \
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
