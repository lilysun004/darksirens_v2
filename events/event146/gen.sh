lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 30.52284284284284 --fixed-mass2 37.162322322322325 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002345437.9161813 \
--gps-end-time 1002352637.9161813 \
--d-distr volume \
--min-distance 2537.630201153388e3 --max-distance 2537.6502011533885e3 \
--l-distr fixed --longitude -152.0290069580078 --latitude -44.031349182128906 --i-distr uniform \
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
