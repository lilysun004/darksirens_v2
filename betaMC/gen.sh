lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 5.561761761761762 --fixed-mass2 46.07099099099099 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003965732.2696866 \
--gps-end-time 1003972932.2696866 \
--d-distr volume \
--min-distance 549.7232915311351e3 --max-distance 549.7432915311351e3 \
--l-distr fixed --longitude 47.648891517465096 --latitude -5.226248025253559 --i-distr uniform \
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
