lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.56548548548549 --fixed-mass2 71.95655655655656 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016785111.3238215 \
--gps-end-time 1016792311.3238215 \
--d-distr volume \
--min-distance 1811.7382143601035e3 --max-distance 1811.7582143601035e3 \
--l-distr fixed --longitude 72.2920913696289 --latitude 56.014217376708984 --i-distr uniform \
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
