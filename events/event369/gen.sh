lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.908948948948947 --fixed-mass2 14.47043043043043 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020167058.4481372 \
--gps-end-time 1020174258.4481372 \
--d-distr volume \
--min-distance 1335.0090160991851e3 --max-distance 1335.0290160991851e3 \
--l-distr fixed --longitude 163.95115661621094 --latitude 54.76325225830078 --i-distr uniform \
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
