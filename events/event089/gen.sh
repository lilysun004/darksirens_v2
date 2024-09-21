lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.360800800800803 --fixed-mass2 44.5581981981982 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026848566.4882178 \
--gps-end-time 1026855766.4882178 \
--d-distr volume \
--min-distance 722.3416258561036e3 --max-distance 722.3616258561036e3 \
--l-distr fixed --longitude -91.63629150390625 --latitude 28.04559326171875 --i-distr uniform \
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
