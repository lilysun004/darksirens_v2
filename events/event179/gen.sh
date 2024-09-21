lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 48.592312312312316 --fixed-mass2 48.424224224224226 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017240397.9487115 \
--gps-end-time 1017247597.9487115 \
--d-distr volume \
--min-distance 3206.3880969631437e3 --max-distance 3206.408096963144e3 \
--l-distr fixed --longitude 138.72976684570312 --latitude 47.75740432739258 --i-distr uniform \
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
