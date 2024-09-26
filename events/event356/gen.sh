lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.488728728728727 --fixed-mass2 58.593553553553555 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026660621.4909636 \
--gps-end-time 1026667821.4909636 \
--d-distr volume \
--min-distance 820.9051611946758e3 --max-distance 820.9251611946758e3 \
--l-distr fixed --longitude -1.444091796875 --latitude 1.8079752922058105 --i-distr uniform \
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
