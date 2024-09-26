lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.615415415415416 --fixed-mass2 73.88956956956957 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001178624.657657 \
--gps-end-time 1001185824.657657 \
--d-distr volume \
--min-distance 1246.1433697055106e3 --max-distance 1246.1633697055106e3 \
--l-distr fixed --longitude -158.98304748535156 --latitude 51.166046142578125 --i-distr uniform \
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
