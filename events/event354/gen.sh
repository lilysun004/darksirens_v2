lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 48.08804804804805 --fixed-mass2 62.795755755755756 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006318128.1882205 \
--gps-end-time 1006325328.1882205 \
--d-distr volume \
--min-distance 2019.2458679046485e3 --max-distance 2019.2658679046485e3 \
--l-distr fixed --longitude -69.83267211914062 --latitude 78.58460998535156 --i-distr uniform \
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
