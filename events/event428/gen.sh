lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.41321321321321 --fixed-mass2 69.18310310310311 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022887331.059052 \
--gps-end-time 1022894531.059052 \
--d-distr volume \
--min-distance 1533.5210056297096e3 --max-distance 1533.5410056297096e3 \
--l-distr fixed --longitude -29.998260498046875 --latitude -16.15328598022461 --i-distr uniform \
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
