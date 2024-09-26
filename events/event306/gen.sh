lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.68116116116116 --fixed-mass2 14.63851851851852 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013816962.9620546 \
--gps-end-time 1013824162.9620546 \
--d-distr volume \
--min-distance 1174.4301173990877e3 --max-distance 1174.4501173990877e3 \
--l-distr fixed --longitude -101.09793090820312 --latitude 0.6273781657218933 --i-distr uniform \
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
