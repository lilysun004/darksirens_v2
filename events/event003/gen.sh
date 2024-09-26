lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 55.23179179179179 --fixed-mass2 59.09781781781782 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004774160.5435644 \
--gps-end-time 1004781360.5435644 \
--d-distr volume \
--min-distance 3075.4508896115794e3 --max-distance 3075.47088961158e3 \
--l-distr fixed --longitude -143.9180908203125 --latitude 79.31626892089844 --i-distr uniform \
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
