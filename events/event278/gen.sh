lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 5.225585585585586 --fixed-mass2 7.074554554554555 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001983028.9335612 \
--gps-end-time 1001990228.9335612 \
--d-distr volume \
--min-distance 412.03910905203605e3 --max-distance 412.05910905203604e3 \
--l-distr fixed --longitude 77.95743560791016 --latitude 22.996009826660156 --i-distr uniform \
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
