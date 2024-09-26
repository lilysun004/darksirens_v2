lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 3.2925725725725727 --fixed-mass2 54.475395395395395 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009976839.5636507 \
--gps-end-time 1009984039.5636507 \
--d-distr volume \
--min-distance 378.5640098970583e3 --max-distance 378.5840098970583e3 \
--l-distr fixed --longitude -103.28839111328125 --latitude -73.8765869140625 --i-distr uniform \
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
