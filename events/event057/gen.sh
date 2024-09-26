lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.158598598598599 --fixed-mass2 35.145265265265266 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003530408.4235698 \
--gps-end-time 1003537608.4235698 \
--d-distr volume \
--min-distance 542.8434461455273e3 --max-distance 542.8634461455273e3 \
--l-distr fixed --longitude -114.78160095214844 --latitude -0.8804182410240173 --i-distr uniform \
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
