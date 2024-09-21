lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.6628628628628634 --fixed-mass2 27.917477477477476 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029652891.1560864 \
--gps-end-time 1029660091.1560864 \
--d-distr volume \
--min-distance 1236.6222920113253e3 --max-distance 1236.6422920113253e3 \
--l-distr fixed --longitude 60.793601989746094 --latitude -47.72242736816406 --i-distr uniform \
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
