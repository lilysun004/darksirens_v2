lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 47.07951951951952 --fixed-mass2 28.505785785785786 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029158348.8460898 \
--gps-end-time 1029165548.8460898 \
--d-distr volume \
--min-distance 1541.3213175592127e3 --max-distance 1541.3413175592127e3 \
--l-distr fixed --longitude 130.68875122070312 --latitude -78.81100463867188 --i-distr uniform \
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
