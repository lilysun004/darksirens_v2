lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.344984984984983 --fixed-mass2 48.08804804804805 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011368859.6041687 \
--gps-end-time 1011376059.6041687 \
--d-distr volume \
--min-distance 2626.0261731674973e3 --max-distance 2626.0461731674977e3 \
--l-distr fixed --longitude 145.50186157226562 --latitude -75.06827545166016 --i-distr uniform \
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
