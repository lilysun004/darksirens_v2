lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.55695695695696 --fixed-mass2 37.4984984984985 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029407029.8460122 \
--gps-end-time 1029414229.8460122 \
--d-distr volume \
--min-distance 2823.5207231414506e3 --max-distance 2823.540723141451e3 \
--l-distr fixed --longitude -48.444061279296875 --latitude 64.98076629638672 --i-distr uniform \
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
